class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable, :trackable, :confirmable, 
  # the confirmable module was blocking user account (or session?) creation
  devise :database_authenticatable, :recoverable, :validatable, :registerable, :rememberable

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :moderator, :admin]
  
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :user
  # end
end
