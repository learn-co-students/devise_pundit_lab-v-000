# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_notes_on_user_id  (user_id)
#

class Note < ActiveRecord::Base
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  before_save :ensure_owner_can_read

  def visible_to=(new_readers)
    # binding.pry
    self.readers = new_readers.split(',').collect do |name|
      User.find_by(name: name.squish)
    end.compact
  end

  def visible_to
    readers.collect do |user|
      user.name
    end.join(', ')
  end

  private

  def ensure_owner_can_read
    if user && !readers.include?(user)
      readers << user
    end
  end
end
