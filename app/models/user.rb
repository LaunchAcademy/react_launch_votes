class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates_format_of :email, with: EMAIL_REGEXP, allow_blank: true
  validates_presence_of :image_url, :name
  validates_uniqueness_of :github_uid

  def update_from_github(auth_hash)
    assign_attributes(
      image_url: auth_hash["info"]["image"],
      name: auth_hash["info"]["name"])
    self
  end

  def self.new_from_github(auth_hash)
    new(
      github_uid: auth_hash["uid"],
      image_url: auth_hash["info"]["image"],
      name: auth_hash["info"]["name"])
  end

end
