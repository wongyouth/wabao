class AdminController < ApplicationController
  def index
  end

  def categories
    @categories = Top.request({
      :method => 'taobao.itemcats.get',
      :fields => 'cid,parent_id,name,is_parent',
      :parent_cid => 0
    })

    render :json => @categories
  end

  def items
    hash = {
      :method => 'taobao.taobaoke.items.get',
      :fields => "num_iid,title,nick,pic_url,price,click_url, commission,commission_num,volume",
      :keyword => params[:keyword],
      :cid => params[:category_id].presence || '0',
      :order => 'credit_desc',
      :guarantee => 'true',
      :start_commissionRate => '500',
      :end_commissionRate => '5000',
      :mall_item => 'true',
      :pid => Top::PID
    }

    @items = Top.request(hash)['taobaoke_items_get_response']['taobaoke_items']['taobaoke_item']
  end

  def images
    item_id = params[:item_id]
    @images = Top.request({
      :method => 'taobao.item.get',
      :fields => 'prop_img.url,item_img.url,nick',
      :num_iid => item_id
    })

    item = @images['item_get_response']['item']
    imgs = []
    imgs << item['item_imgs']['item_img'] if item['item_imgs']
    imgs << item['prop_imgs']['prop_img'] if item['prop_imgs']
    render :json => imgs.flatten
  end

  def stats
  end
end
