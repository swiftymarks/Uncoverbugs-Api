class User < ApplicationRecord
    enum user_type: { admin: 0, tester: 1, company: 2 }
    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :first_name,  :presence => true
    validates :last_name,   :presence => true
    validates :email,       :presence => true, format: { with: VALID_EMAIL_REGEX }
    validates :username,    :presence => true
    validates :user_type,   inclusion: { in: User.user_types.keys }    
    has_secure_password   
    has_one :company
    has_one :tester
end
