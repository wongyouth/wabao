class ItemsController < ApplicationController
  def index
    @q = Item.search(params[:q])
    @items = @q.result.page(params[:page])
  end
end
