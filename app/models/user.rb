class User < ActiveRecord::Base
  
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?


    def set_default_role
      self.role ||= :user
    end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable#:recoverable, :rememberable, :trackable,
  #:confirmable,
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, 
          :rememberable, :trackable, :confirmable, :validatable
  
  

  has_many :notes
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  

end
