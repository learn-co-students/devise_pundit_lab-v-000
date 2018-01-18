class User < ActiveRecord::Base
  # :recoverable, :rememberable, :trackable
   devise :database_authenticatable, :registerable, :validatable
    has_many :notes
    has_many :viewers
    has_many :readable, through: :viewers, source: :note
 
   enum role: [:normal, :moderator, :admin]
 
   after_initialize :set_default_role
 
   def set_default_role
     self.role ||= :normal
   end
end
