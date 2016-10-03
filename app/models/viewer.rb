# == Schema Information
#
# Table name: viewers
#
#  id         :integer          not null, primary key
#  note_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_viewers_on_note_id  (note_id)
#  index_viewers_on_user_id  (user_id)
#

class Viewer < ActiveRecord::Base
  belongs_to :note
  belongs_to :user
end
