class UserInformation < ApplicationRecord
  belongs_to :user
  validates_presence_of :first_name, :last_name, :date_of_birth
end
