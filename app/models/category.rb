class Category < ActiveRecord::Base
  attr_accessible :id, :name, :slug
  has_many :items

  before_create do
    self.slug = name
  end
end
