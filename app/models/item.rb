class Item < ActiveRecord::Base
  attr_accessible :click_url, :commission, :num_iid, :pic_url, :price, :nick, :title, :volume
end
