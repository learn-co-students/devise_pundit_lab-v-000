class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :validatable#, :trackable, :rememberable,  :recoverable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :admin]

  # after_initialize :set_default_role #Would make much more sense to do this in the database. And apparently the mdomel too.
  #
  # def set_default_role
  #   self.role = :user
  # end

end
