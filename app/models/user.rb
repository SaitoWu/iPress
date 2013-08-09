# coding: utf-8
require "digest/md5"
class User
  include Mongoid::BaseModel
  
  field :login
  field :password
  field :email
  
  validates_uniqueness_of :login, :email
  validates_presence_of :login, :email, :password
  
  before_create :encode_password
  def encode_password
    self.password = Digest::MD5.hexdigest(self.password)
  end
  
  def is_valid_password?(pass)
    if self.password != Digest::MD5.hexdigest(pass)
      self.errors.add(:password, "Not match.")
      return false
    else
      return true
    end
  end
end