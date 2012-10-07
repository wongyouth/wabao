require 'digest'
require 'uri'
require 'open-uri'
require 'active_support/core_ext'
require 'active_support/configurable'
require 'json'

class Top
  APPKEY = '12673864'
  APPSECRET = 'd4cb57d3eec5d6f1cbbfd0f430caf282'
  PID = '32858933'
  #APPKEY = 'test'
  #APPSECRET = 'test'
  #GATEWAY = "http://gw.api.tbsandbox.com/router/rest"
  GATEWAY = "http://gw.api.taobao.com/router/rest"
  attr_accessor :format, :sign_method
  attr_accessor :app_key, :app_secret

  def initialize(options)
    @sign_method = options[:sign_method] || :md5
    @format = options[:format] || :json
  end

  def self.sign(params, sign_method = :md5)
    case sign_method
    when :hmac
      Digest::HMAC.hexdigest("#{APPSECRET}#{ordered_params_string(params)}", APPSECRET, Digest::MD5).upcase
    else
      Digest::MD5::hexdigest("#{APPSECRET}#{ordered_params_string(params)}#{APPSECRET}").upcase
    end
  end

  def self.ordered_params_string(params)
    params.map do |k, v|
      "#{k}#{v}"
    end.sort.join
  end

  def self.url(params)
    params = {
      :timestamp => Time.now.strftime("%F %T"),
      :v => "2.0",
      :format => :json,
      :sign_method => :md5,
      :app_key => APPKEY
    }.merge params
    "%s?%s" % [GATEWAY, params.merge(:sign => sign(params)).to_query]
  end

  def url(params)
    params = {:format => @format, :sign_method => @sign_method}.merge params
    self.class.url params
  end

  def self.request(params)
    path = url(params)
    puts path
    response = open(path).read
    JSON.parse response
  end
end

# def pretty(json)
#   puts JSON.pretty_generate(json)
# end
# 
# params = {
#   :method => "taobao.itemcats.get",
#   :fields => "cid,parent_id,name,is_parent",
#   :parent_cid => 0
# }
# 
# pretty(Top.request(params))
# 
# params = {
#   :method => "taobao.taobaoke.items.get",
#   :fields => "num_iid,title,nick,pic_url,price,click_url, commission,commission_num,volume",
#   :cid => 30, # 男装
#   :pid => Top::PID
# }
# 
# pretty(Top.request(params))
# 
# params = {
#   :method => "taobao.item.get",
#   :fields => "prop_img.url,item_img.url,nick",
#   :num_iid => 19276752117
# }
# 
# pretty(Top.request(params))
# 
