class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :nominations, foreign_key: :nominee_id
  has_many :memberships
  has_many :teams, through: :memberships

  validates_format_of :email, with: EMAIL_REGEXP, allow_blank: true
  validates_presence_of :image_url, :name
  validates_uniqueness_of :handle, :github_id

  def to_param
    handle
  end

  def update_from_github(auth_hash)
    assign_attributes(
      handle: auth_hash["info"]["nickname"],
      image_url: auth_hash["info"]["image"],
      name: auth_hash["info"]["name"])
    self
  end

  def update_from_launch_pass(auth_hash)
    assign_attributes(
      email: auth_hash["info"]["email"],
      launch_pass_id: auth_hash["info"]["id"])
    self
  end

  def self.new_from_github(auth_hash)
    new(
      github_id: auth_hash["uid"],
      handle: auth_hash["info"]["nickname"],
      image_url: auth_hash["info"]["image"],
      name: auth_hash["info"]["name"])
  end

end
