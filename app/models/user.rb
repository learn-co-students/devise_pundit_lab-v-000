class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  after_initialize :set_user_role



  enum role: [:admin, :user, :moderator]

  private

  def set_user_role
    self.role ||= :user
  end
end
