class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :vip, :admin]

  before_create :set_default_role, :user_name


  def set_default_role
    self.role ||= :user
  end

  def user_name
    self.name ||= self.email    
  end
end
