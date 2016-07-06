class Note < ActiveRecord::Base
  belongs_to :user
  has_many :viewers  
  has_many :readers, through: :viewers, source: :user

  before_save :ensure_owner_can_read
  
  def visible_to
    readers.map { |u| u.email }.join(', ')
  end

  def visible_to=(new_readers)
    self.readers = new_readers.split(',').map do |name|
      User.find_by(name: name.strip) || User.find_by(email: name.strip)
    end.compact
  end
  
  # def visible_to=(new_readers)
  #   readers = new_readers.split(',').map do |name| 
  #     User.find_by(name: name.strip) || User.find_by(email: name.strip)
  #   end
  #   readers.each do |reader|
  #     self.readers << reader
  #   end
  # end
  
  def hide_from(reader)
    this_reader = User.find_by(name: reader.strip) || User.find_by(email: reader.strip)
    self.readers.delete(this_reader)
  end

  private

  def ensure_owner_can_read
    if user && !readers.include?(user)
      readers << user
    end
  end
end
