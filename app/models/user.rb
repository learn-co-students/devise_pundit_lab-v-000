class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note
  
  enum role: { user: 0, vip: 1, admin: 2 }
  
  def role_name 
    if self.user?
      "user"  
    elsif self.vip?
      "vip"
    elsif self.admin?
      "admin"
    else 
      nil
    end
  end
end
