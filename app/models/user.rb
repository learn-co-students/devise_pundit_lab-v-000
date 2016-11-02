class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:normal, :admin]
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
  after_initialize :default

  def default
    self.role = :normal
  end
end
