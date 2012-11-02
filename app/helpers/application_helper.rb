module ApplicationHelper
  def format_price(price)
    number_with_precision(price, precision: 2)
  end
end
