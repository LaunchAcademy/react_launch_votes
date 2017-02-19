class Vote < ApplicationRecord
  belongs_to :nomination, counter_cache: true
  belongs_to :user
end
