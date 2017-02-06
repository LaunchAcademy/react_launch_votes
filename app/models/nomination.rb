class Nomination < ApplicationRecord
  belongs_to :nominator, class_name: "User"
  belongs_to :nominee, class_name: "User"

  validates_presence_of :body, :nominator, :nominee
end
