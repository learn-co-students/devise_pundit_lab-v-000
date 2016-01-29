class User < ActiveRecord::Base
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
end
