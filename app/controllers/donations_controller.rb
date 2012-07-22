class DonationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  protect_from_forgery :except => [:thanks, :ipn, :cancel]
  before_filter :only_admin, :except => [:thanks, :ipn, :cancel, :list, :index]
  #load_and_authorize_resource

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donations }
    end
  end

  # GET /donations/list
  # GET /donations/list.json
  def list
    @donations = Donation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donations }
    end
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @donation = Donation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donation }
    end
  end

  # GET /donations/new
  # GET /donations/new.json
  def new
    @donation = Donation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @donation }
    end
  end

  # GET /donations/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(params[:donation])

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render json: @donation, status: :created, location: @donation }
      else
        format.html { render action: "new" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /donations/1
  # PUT /donations/1.json
  def update
    @donation = Donation.find(params[:id])

    respond_to do |format|
      if @donation.update_attributes(params[:donation])
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy

    respond_to do |format|
      format.html { redirect_to donations_url }
      format.json { head :no_content }
    end
  end

  # NON-Restfull
  def thanks
    flash[:notice] = "Merci pour la donation !"
    redirect_to root_path
  end
  def cancel
    flash[:notice] = "Oh :("
    redirect_to root_path
  end
  def ipn
    Log.logit!(:donations, :important, "Receiving a PayPal IPN request", {})
    notify = Paypal::Notification.new request.raw_post
    @don = Donation.new
    if notify.acknowledge
      if notify.complete?
        @custom_things = YAML::load(params[:custom])
        if @custom_things[:user_id] != 0
          @don.user_id = @custom_things[:user_id]
        else
          @don.user_id = nil
        end
        @don.amount = BigDecimal.new(params[:mc_gross])
        if @don.save
          Log.logit!(:donations, :important, "Saved IPN donation #{@don.id}", {:donation_id => @don.id})
        else
          Log.logit!(:donations, :important, "Error while saving IPN: #{@don.errors}", {:donation_id => @don.id})
        end

        return render :nothing => true
      else
        Log.logit!(:donations, :important, "Got incomplete IPN, payement: #{notify.status}", {})
      end
    else
      Log.logit!(:donations, :important, "Got IPN error", {})
    end
    return redirect_to root_path
  end


end
