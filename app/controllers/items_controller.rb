class ItemsController < ApplicationController
  def index
    @q = Item.search(params[:q])
    @items = @q.result.page(params[:page])
  end

  def show
    @q = Item.search(params[:q])
    @items = @q.result.page(params[:page])
    render :index2
  end
end
