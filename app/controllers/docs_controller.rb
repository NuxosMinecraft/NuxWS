class DocsController < ApplicationController
  load_and_authorize_resource

  # GET /docs
  # GET /docs.json
  def index
    @docs = Doc.page params[:page]
    @feed_link = docs_url(:format => :atom)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docs }
      format.atom { render :layout => false }
    end
  end

  # GET /docs/xxx
  # GET /docs/xxx.json
  def show
    @doc = Doc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @doc }
    end
  end

  # GET /docs/new
  # GET /docs/new.json
  def new
    @doc = Doc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @doc }
    end
  end

  # GET /docs/xxx/edit
  def edit
    @doc = Doc.find(params[:id])
  end

  # POST /docs
  # POST /docs.json
  def create
    @doc = Doc.new(params[:doc])

    respond_to do |format|
      if @doc.save
        Log.logit!(:docs, :notice, "User created doc " + @doc.title, {:user_id => @current_user.id, :doc_id => @doc.id})
        format.html { redirect_to @doc, notice: 'Doc was successfully created.' }
        format.json { render json: @doc, status: :created, location: @doc }
      else
        format.html { render action: "new" }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /docs/xxx
  # PUT /docs/.json
  def update
    @doc = Doc.find(params[:id])

    respond_to do |format|
      if @doc.update_attributes(params[:doc])
        Log.logit!(:docs, :notice, "User updated doc " + @doc.title, {:user_id => @current_user.id, :doc_id => @doc.id})
        format.html { redirect_to @doc, notice: 'Doc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docs/xxx
  # DELETE /docs/xxx.json
  def destroy
    @doc = Doc.find(params[:id])
    Log.logit!(:docs, :notice, "User deleted doc " + @doc.title, {:user_id => @current_user.id, :doc_id => @doc.id})
    @doc.destroy

    respond_to do |format|
      format.html { redirect_to docs_path }
      format.json { head :no_content }
    end
  end

end
