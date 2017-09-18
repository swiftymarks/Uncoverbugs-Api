class Platform < ApplicationRecord
  validates :name, presence: true
  
  def self.random_name
    platforms = ["OS X", "Windows", "iOS App", "Android App", "Web App"]
    platforms.sample
  end
end
