class Item < ActiveRecord::Base
  attr_accessible :click_url, :commission, :num_iid, :pic_url, :price, :nick, :title, :volume, :category_id, :promotion_price

  belongs_to :category

  def fetch_promotion_price
    ret = OpenTaobao.get({
      method: 'taobao.ump.promotion.get',
      item_id: num_iid
    }).with_indifferent_access

    self.promotion_price = ret[:ump_promotion_get_response][:promotions][:promotion_in_item][:promotion_in_item][0][:item_promo_price] rescue nil
  end

  def update_price
    ret = Opentaobao.get({
      method: 'taobao.item.get',
      fields: 'price',
      item_id: num_iid
    }).with_indifferent_access

    self.price = ret[:item_get_response][:item][:price] rescue price
    fetch_promotion_price

    save!
  end

  class << self
    def fetch_images(item_id)
      OpenTaobao.get({
        :method => 'taobao.item.get',
        :fields => 'prop_img.url,item_img.url,nick',
        :num_iid => item_id
      })
    end

    def fetch_items(params)
      hash = {
        :method => 'taobao.taobaoke.items.get',
        :fields => "num_iid,title,nick,pic_url,price,click_url, commission,commission_num,volume",
        :sort => 'credit_desc',
        :guarantee => 'true',
        :start_commissionRate => '500',
        :end_commissionRate => '5000',
        :mall_item => 'true',
        :page_no => '1',
        :outer_code => '0',
        :pid => OpenTaobao.config['pid']
      }

      if params[:keyword].present?
        hash.merge! keyword: params[:keyword]
      else
        hash.merge! cid: params[:category_id].presence || '0'
      end

      puts hash
      OpenTaobao.get hash
    end
  end
end
