class StatsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def shops
    @items = Item.select("nick, count(id) item_count, sum(click_counter) sum_click").group(:nick).page(params[:page])
  end

  def categories
    @categories = Category.page(params[:page])
  end
end
