class AdminController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def categories
    @categories = OpenTaobao.get({
      :method => 'taobao.itemcats.get',
      :fields => 'cid,parent_id,name,is_parent',
      :parent_cid => 0
    })

    render :json => @categories
  end

  def items
    @items = Item.fetch_items(params, current_user)['taobaoke_items_get_response']['taobaoke_items']['taobaoke_item'] rescue []
  end

  def images
    item_id = params[:item_id]
    @images = Item.fetch_images(item_id)

    item = @images['item_get_response']['item']
    imgs = []
    imgs << item['item_imgs']['item_img'] if item['item_imgs']
    imgs << item['prop_imgs']['prop_img'] if item['prop_imgs']
    render :json => { images: imgs.flatten, cid: item['cid'] }
  end

  def stats
  end
end
