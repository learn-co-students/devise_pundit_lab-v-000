describe NotePolicy do
  subject { NotePolicy }

  before do
    Note.destroy_all
    User.destroy_all
    @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    @new_note_1 = @user.notes.build(content: "apples")
    @new_note_1.save
    @vip = User.create(name: "B",email: "b@b.com",password: "BBBBBBBBBBBB",role: 1)
    @admin = User.create(name: "C",email: "c@c.com",password: "CCCCCCCCCCCCCCCCC",role: 2)
    @other_user = User.create(name: "D",email: "d@d.com",password: "DDDDDDDDDDDDDDDDDDDDD")
    @authorized_reader = User.create(name: "E",email:"e@e.com",password: "EEEEEEEEEEEEEEEEEEEE")
    @unsaved_note_1 = @user.notes.build(content: "bananas")
   end

  permissions :show? do
    it "can view your own notes" do
  
      expect(subject).to permit(@user,@new_note_1)
    end
    it "allows vip to view notes" do
      expect(subject).to permit(@vip,@new_note_1)
    end
    it "allows admin to view notes" do
      expect(subject).to permit@admin,(@new_note_1)
    end
    it "cannot view note you are not reader of" do
      expect(subject).to_not permit(@other_user,@new_note_1)
    end
    it "can view a note you are a reader of" do
      @new_note_1.readers << @authorized_reader
      @new_note_1.save
      expect(subject).to permit( @authorized_reader,@new_note_1)
    end
  
  end

  permissions :update? do
    it "allows a user to edit their own post" do
      expect(subject).to permit(@user,@new_note_1)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(@admin,@new_note_1)
    end
    it "prevents vip to update notes" do
      expect(subject).not_to permit(@vip,@new_note_1)
    end
    it "cannot edit another user's note" do
      expect(subject).to_not permit(@other_user,@new_note_1)
    end
  end

  permissions :destroy? do
    it "can delete your own note" do
      expect(subject).to permit(@user,@new_note_1)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(@admin,@new_note_1)
    end
    it "prevents vip to delete notes" do
      expect(subject).not_to permit(@vip,@new_note_1)
    end
     it "cannot delete another user's note" do
      expect(subject).to_not permit(@other_user,@new_note_1)
    end
  end
  
end