class User < ActiveRecord::Base
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :validatable, :recoverable, :rememberable

  enum role: [:user, :moderator, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
end
