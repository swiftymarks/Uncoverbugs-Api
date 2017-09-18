class Tester < ApplicationRecord
    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i    
    enum gender: { male: 0, female: 1, any: 2 }
    validates :address1, presence: true
    validates :province,  presence: true
    validates :skype_id, presence: true
    validates :mobile_number, presence: true
    validates :gender,  presence: true, inclusion: { in: Tester.genders.keys }
    validates :born_year, presence: true    
    validates :paypal_email, presence: true, format: { with: VALID_EMAIL_REGEX }

    belongs_to :user
    has_many :tester_devices, :class_name => 'TesterDevice'
    has_many :devices, :through => :tester_devices
    has_one :notification_setting
end