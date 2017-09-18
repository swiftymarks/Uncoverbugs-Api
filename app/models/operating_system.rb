class OperatingSystem < ApplicationRecord
  validates :name, presence: true
  
  def self.random_name
    operating_systems = ["iOS 7", "iOS 8", "iOS 9", "iOS 10", "Android 5.0.0", "Android 6.1"]
    operating_systems.sample
  end
end