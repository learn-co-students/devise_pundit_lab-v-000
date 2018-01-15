class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable

  enum role: [:normal, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  def set_default_role
    self.role ||= :normal
  end

end
