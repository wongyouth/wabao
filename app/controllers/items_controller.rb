class ItemsController < ApplicationController
  load_and_authorize_resource except: [:index, :show]

  def index
    #@q = Item.search(params[:q])
    #@items = @q.result.page(params[:page])
    @items = Item.search(params[:q]).page(params[:page])
    @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
    @categories = Category.all
  end

  def create
    item = Item.new params[:item]
    item.fetch_promotion_price

    if Item.where({num_iid: item[:num_iid]}).exists? || item.save
      head :ok
    else
      render :text => item.errors.full_messages, :status => :bad_request
    end
  end

  def show
    @item = Item.find_by(slug: params[:id]) do |i|
      i.inc :click_counter, 1
    end

    respond_to do |format|
      format.html { redirect_to @item.click_url }
      format.json { render json: @item.click_url }
    end
  end
end
