class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :slug, type: String

  attr_accessible :name, :slug
  has_many :items

  before_save do
    self.slug = Pinyin.t name, '-'
  end

  def to_param
    slug
  end
end
