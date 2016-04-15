class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum :role => [:admin, :vip, :user]

  after_initialize :set_default_role_to_user

  def set_default_role_to_user
    self.role = 'user'
  end

end
