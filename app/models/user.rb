class User < ActiveRecord::Base

  devise :registerable, :database_authenticatable, :validatable
  
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:normal, :vip, :admin]

end
