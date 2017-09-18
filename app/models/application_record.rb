class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
