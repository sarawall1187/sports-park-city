class Athlete < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  validates_uniqueness_of :email
  has_secure_password
end
