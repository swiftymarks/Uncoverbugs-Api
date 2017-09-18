class Company < ApplicationRecord
    validates :company_name, :length => { :minimum   => 1, :maximum   => 80 }, presence: true
    validates :company_url, :length => { :minimum   => 1 }, presence: true
    belongs_to :user
    has_many :projects
end
