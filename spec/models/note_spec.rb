require 'rails_helper'

describe Note, type: :model do
  let(:user1) { User.create!(name: "Joe", password: "mysecret", email: "joe@example.com", role: 0) }

  let(:user2) { User.create!(name: "Jane", password: "mysecret", email: "jane@example.com") }

  let(:user3) { User.create!(name: "Jason", password: "mysecret", email: "jason@example.com") }

  let(:note) { Note.create!(content: "bla bla bla", user_id: user1.id, ) }

  let(:viewer) { Viewer.create!(note_id: note.id, user_id: user1.id)}


  it "is valid with content and a user_id" do
    expect(note).to be_valid
  end

  it "belongs to one user" do
    expect(note.user).to eql(user1)
  end

  it "has many readers through viewers" do
    expect(note.readers.first).to eql(user1)
  end

  describe "#ensure_owner_can_read" do
    it "when saving a new note, it adds the notes' owner to the list of readers if not allready included" do
        new_note = user3.notes.create!(content: "bla bla")

        expect(new_note.readers.first).to eql(new_note.user)
    end
  end
  describe "#visible_to=" do
    it "takes a list of names and converts them to 'readers'" do
      list_of_readers = "#{user2.name}, #{user3.name}"
      note.visible_to=(list_of_readers)

      expect(note.readers.count).to eql(2)
    end
  end

  describe "visible_to" do
    it "takes a collection of note.readers and displays their names as a string" do
      name = note.visible_to

      expect(name).to eql(note.user.name)
    end
  end


end




# before(:each) { @user = User.new(email: 'user@example.com') }
#
# subject { @user }
#
# it { should respond_to(:email) }
#
# it "#email returns a string" do
#   expect(@user.email).to match 'user@example.com'
# end
