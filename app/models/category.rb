class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :show, type: Boolean, default: false

  #attr_accessible :name, :slug, :show

  belongs_to :parent, class_name: "Category", inverse_of: :categories
  has_many :categories, inverse_of: :parent
  has_many :items

  scope :active, where(show: true)
  
  def ancestors
    l = [c = self]
    while c = c.parent
      l << c
    end
    l
  end
end
