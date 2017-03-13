class User < ActiveRecord::Base
  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable, :validatable

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  def set_default_role
    self.role ||= :user
  end

end
