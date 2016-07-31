class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Got error EOFError End of file reached.
  # http://stackoverflow.com/questions/16819801/rails-eoferror-end-of-file-reached-when-saving-a-devise-user
  # removed :confirmable because this has something to do with ActionMailer
  
  has_many :notes
  has_many :viewers
  has_many :readable, through: :viewers, source: :note

  enum role: [:user, :admin]

end
