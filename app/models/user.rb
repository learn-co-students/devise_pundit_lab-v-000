class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable, :validatable
  enum role: [:user, :vip, :admin]

  after_initialize :set_role, :if => :new_record?

  def set_role
    self.role ||= :user
  end

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
end
