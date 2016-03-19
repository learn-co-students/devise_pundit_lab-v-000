class User < ActiveRecord::Base

  devise :registerable, :database_authenticatable, :rememberable
  #devise :database_authenticatable, :registerable, :confirmable,
  #       :recoverable, :rememberable, :trackable, :validatable
  
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :vip, :admin]
end
