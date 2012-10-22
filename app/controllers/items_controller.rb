class ItemsController < ApplicationController
  def index
    @q = Item.search(params[:q])
    @items = @q.result.page(params[:page])
    @items = @items.where(category_id: params[:category_id]) if params[:category_id].present?
    @categories = Category.all
  end

  def create
    item = Item.new params[:item]
    if Item.find_by_num_iid(item[:num_iid]) || item.save
      head :ok
    else
      render :text => item.errors.full_messages, :status => :bad_request
    end
  end

  def show
    @item = Item.find(params[:id])
    @item.increment! :click_counter

    respond_to do |format|
      format.html { redirect_to @item.click_url }
      format.json { render json: @item.click_url }
    end
  end
end
