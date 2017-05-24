class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable, :registerable

  enum role: [:reader, :user, :moderator, :admin]
         
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
end
