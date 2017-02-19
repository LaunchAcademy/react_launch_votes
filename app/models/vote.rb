class Vote < ApplicationRecord
  belongs_to :nomination, counter_cache: true
  belongs_to :user

  validates_presence_of :nomination, :user
end
