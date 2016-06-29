class User < ActiveRecord::Base
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable, :trackable, 

  enum role: [:normal, :moderator, :admin]

  devise :database_authenticatable, :registerable, :validatable, :rememberable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

end
