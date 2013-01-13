# encoding: utf-8

class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleCaptcha::ModelHelpers

  field :title, type: String
  field :body, type: String

  belongs_to :user

  attr_accessible :body, :title
  attr_accessible :captcha, :captcha_key
  #apply_simple_captcha message: "验证码错误。"

  validates_presence_of :title
end
