
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:normal, :moderator, :admin]

  def viewer?(user, note) 
    note.readers.any? {|u| user.id == u.id }
  end 
  
end