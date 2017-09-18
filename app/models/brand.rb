class Brand < ApplicationRecord
  validates :name, presence: true

  def self.random_name
    brands = ["LG", "Samsung", "Apple", "HTC", "Lenovo", "Nokia"]
    brands.sample
  end
end