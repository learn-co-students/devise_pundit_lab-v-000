class User < ActiveRecord::Base
  enum role: [:normal, :vip, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
end
