class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role 

  private
  def set_default_role
    self.role ||= 0
  end
  # enum role: [:normal, :moderator, :admin]
  #was asked to add this. if it needs to be added, i also need a migration i think
end
