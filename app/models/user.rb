class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_initialize :set_default_role
  attr_accessor :role

  enum role: [:user, :admin]
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  def set_default_role
    self.role = :user unless self.role
  end
end
