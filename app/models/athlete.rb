class Athlete < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  has_secure_password
end
