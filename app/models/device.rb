class Device < ApplicationRecord
  validates :brand, presence: true
  validates :model, presence: true
  validates :browser, presence: true
  validates :operating_system, presence: true

  has_many :tester_devices, :class_name => 'TesterDevice'
  has_many :testers, :through => :tester_devices
  has_and_belongs_to_many :test_plans
  
  def self.random_brand
    brands = ["Apple", "LG", "Samsung", "Lenovo", "Acer", "Oppa"]
    brands.sample
  end

  def self.random_model
    models = ["iPhone 5s", "iPhone 6", "iPhone 7 Plus", "G3", "Note 8", "S8"]
    models.sample
  end

  def self.random_browser
    browsers = ["Google Chrome", "Safari", "Mozilla Firefox"]
    browsers.sample
  end

  def self.random_operating_system
    operating_systems = ["iOS 7", "iOS 8", "Android 3.2", "Android 5.0.0", "Windows Phone"]
    operating_systems.sample
  end
end