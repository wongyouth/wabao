class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    parent_id = params[:category_id] || 0
    @categories = Top.request({
      :method => 'taobao.itemcats.get',
      :fields => 'cid,parent_id,name,is_parent',
      :parent_cid => parent_id
    })

    @categories =  @categories['itemcats_get_response']['item_cats']['item_cat']
    puts @categories
  end

  def create
    categories = params[:data]
    if Category.create JSON.parse(categories)
      redirect_to :action => :index
    else
      render :new
    end
  end

  def update
  end
end
