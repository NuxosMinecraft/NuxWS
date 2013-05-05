class SearchController < ApplicationController
  def index
  end

  def show
    ctrl = "index"
    if params[:id] == "topics_title"
      @topics = Topic.where(:title.like "%#{params[:q_title]}%").page(params[:page]).per(20)
      ctrl = :topics

    elsif params[:id] == "topics_msg"
      @topics = Topic.where(:content.like "%#{params[:q_msg]}%").page(params[:page]).per(20)
      ctrl = :topics

    elsif params[:id] == "messages"
      @messages = Message.where(:content.like "%#{params[:q_msg]}%").page(params[:page]).per(20)
      ctrl = :messages

    elsif params[:id] == "docs_desc"
      @docs = Doc.where(:description.like "%#{params[:q_desc]}%").page(params[:page]).per(20)
      ctrl = :docs

    elsif params[:id] == "docs_content"
      @docs = Doc.where(:content.like "%#{params[:q_content]}%").page(params[:page]).per(20)
      ctrl = :docs

    elsif params[:id] == "places_shortdesc"
      @places = Place.where(:short_description.like "%#{params[:q_shortdesc]}%").page(params[:page]).per(20)
      ctrl = :places

    elsif params[:id] == "places_desc"
      @places = Place.where(:description.like "%#{params[:q_desc]}%").page(params[:page]).per(20)
      ctrl = :places

    elsif params[:id] == "galleries_title"
      @galleries = Gallery.where(:title.like "%#{params[:q_title]}%").page(params[:page]).per(20)
      ctrl = :galleries

    elsif params[:id] == "galleries_desc"
      @galleries = Gallery.where(:description.like "%#{params[:q_desc]}%").page(params[:page]).per(20)
      ctrl = :galleries

    elsif params[:id] == "images_title"
      @images = Image.where(:title.like "%#{params[:q_title]}%").page(params[:page]).per(20)
      ctrl = :images

    elsif params[:id] == "images_desc"
      @images = Image.where(:description.like "%#{params[:q_desc]}%").page(params[:page]).per(20)
      ctrl = :images

    else
      return redirect_to search_url
    end
    return render ctrl
  end
end
