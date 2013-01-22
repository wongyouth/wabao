class CategoriesController < ApplicationController
  #load_and_authorize_resource

  def index
    @active_categories = Category.active
    @categories = Category.where(parent_id: params[:parent_id].to_i).sort({name: 1}).to_a
    parent = Category.find(params[:parent_id].to_i) rescue nil
    @crumbs = parent ? parent.ancestors.reverse : []
  end

  def new
    parent_id = params[:category_id] || 0
    @categories = OpenTaobao.get({
      :method => 'taobao.itemcats.get',
      :fields => 'cid,parent_id,name,is_parent',
      :parent_cid => parent_id
    })

    @categories =  @categories['itemcats_get_response']['item_cats']['item_cat']
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

  def toggle
    @category = Category.find params[:id].to_i
    @category.show = !@category.show
    @category.save!
    render json: @category.show
  end
end
