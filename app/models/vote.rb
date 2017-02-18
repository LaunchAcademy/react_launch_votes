class Vote < ApplicationRecord
  belongs_to :nomination
  belongs_to :user

  validates_presence_of :nomination, :user
end
