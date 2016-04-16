class User < ActiveRecord::Base
  enum role: [:normal, :moderator, :admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :normal
  end

  devise :authenticatable, :registerable, :validatable

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

end
