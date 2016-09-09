class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
  enum role: [:normal, :admin]
  after_initialize :default_role, if: :new_record?

  def default_role
    self.role ||= :normal
  end

end
