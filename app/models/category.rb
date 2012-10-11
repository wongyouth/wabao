class Category < ActiveRecord::Base
  attr_accessible :id, :name, :slug

  before_create do
    self.slug = name
  end
end
