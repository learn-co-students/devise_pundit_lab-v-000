class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  after_initialize :set_role_if_not_set

  enum :role => [:admin, :moderator, :user]

  def set_role_if_not_set
    self.role ||= :user
  end
end
