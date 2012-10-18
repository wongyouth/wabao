# encoding: utf-8

class Feedback < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :title
  validates_presence_of :title
  apply_simple_captcha message: "验证码错误。"
  attr_accessible :captcha, :captcha_key
end
