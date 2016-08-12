class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :confirmable, :recoverable, :trackable, :validatable, :registerable
  devise :database_authenticatable, :rememberable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:normal, :moderator, :admin]

end
