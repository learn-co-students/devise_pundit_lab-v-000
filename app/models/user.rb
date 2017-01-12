class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :admin]

end
