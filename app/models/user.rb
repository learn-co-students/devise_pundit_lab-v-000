class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  # by default sets to normal user
  after_initialize :set_role_if_not_set

  enum role: [:user, :moderator, :admin]

  private

  # or in the migration =>   add_column :users, :role, :integer, default: 0
  def set_role_if_not_set
  	self.role ||= :user
  end
end
