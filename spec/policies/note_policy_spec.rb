describe NotePolicy do
  subject { NotePolicy }

  let (:guest) { nil }
  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:vip) { FactoryGirl.build_stubbed :user, :vip }
  let(:note) { FactoryGirl.create(:note, user: current_user) }

  permissions :create? do
    it "allows you to create a note if logged in" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to create a note" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your note" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows you to see your own note" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an vip to see any note" do
      expect(subject).to permit(vip, note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :update? do
    it "allows you to update your own note" do
      expect(subject).to permit(current_user, note)
    end
    it "prevents updates if not owner of note" do
      expect(subject).not_to permit(other_user, note)
      expect(subject).not_to permit(vip, note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "allows you to delete your own note" do
      expect(subject).to permit(current_user, note)
    end
    it "prevents others deleting your notes" do
      expect(subject).not_to permit(other_user, note)
      expect(subject).not_to permit(vip, note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, note)
    end
  end

end



# describe NotePolicy do
#   subject { NotePolicy.new(user, note) }

#   context "for current user" do
#     let (:user) { FactoryGirl.build_stubbed :user }
#     let(:note) { Note.new }

#     it { should permit(:show)    }
#     it { should permit(:create)  }
#     it { should permit(:update)  }
#     it { should permit(:destroy) }
#   end

#   context "for a another user" do
#     let (:user) { FactoryGirl.build_stubbed :user }
#     let(:note) { FactoryGirl.build_stubbed :note, user: build(:user) }

#     it { should_not permit(:show)    }
#     it { should_not permit(:create)  }
#     it { should_not permit(:update)  }
#     it { should_not permit(:destroy) }
#   end

#   context "for a vip" do
#     let (:user) { FactoryGirl.build_stubbed :user, :vip }
#     let(:note) { FactoryGirl.build_stubbed :note, user: build(:user) }

#     it { should     permit(:show)    }
#     it { should_not permit(:create)  }
#     it { should_not permit(:update)  }
#     it { should_not permit(:destroy) }
#   end

#   context "for an admin" do
#     let (:user) { FactoryGirl.build_stubbed :user, :admin }
#     let(:note) { FactoryGirl.build_stubbed :note, user: build(:user) }

#     it { should permit(:show)    }
#     it { should permit(:create)  }
#     it { should permit(:update)  }
#     it { should permit(:destroy) }
#   end
# end