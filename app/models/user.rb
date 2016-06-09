class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  after_initialize :default_role, :if => :new_record?

  enum role: [:user, :moderator, :admin]

  private
    def default_role
      self.role ||= :user
    end
end
