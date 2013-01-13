class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def new
    parent_id = params[:category_id] || 0
    @categories = OpenTaobao.get({
      :method => 'taobao.itemcats.get',
      :fields => 'cid,parent_id,name,is_parent',
      :parent_cid => parent_id
    })

    @categories =  @categories['itemcats_get_response']['item_cats']['item_cat']
    puts @categories
  end

  def create
    categories = JSON.parse params[:data]
    if Category.collection.insert categories
      redirect_to :action => :index
    else
      @categories = categories.map {|c| Category.new c}
      render :new
    end
  end

  def update
  end
end
