describe NotePolicy do
    subject {NotePolicy}

    let (:creator) { FactoryGirl.build_stubbed :user }
    let (:admin) { FactoryGirl.build_stubbed :user, :admin }
    let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
    let (:can_read) { FactoryGirl.build_stubbed :user }
    let (:cant_read) { FactoryGirl.build_stubbed :user }

    before(:each) do
        @note = Note.create(user: creator)
        @note.readers << can_read
    end

    permissions :show? do
        it "Allows a user to view their own posts" do
            expect(subject).to permit(creator, @note)
        end
        it "Allows a moderator to view others posts" do
            expect(subject).to permit(moderator, @note)
        end
        it "Allows an admin to view others posts" do
            expect(subject).to permit(admin, @note)
        end
        it "Allows a user to view others posts that they are a reader of" do
            expect(subject).to permit(can_read, @note)
        end
        it "doesn't allow user to view others posts that they are not a reader of" do
            expect(subject).not_to permit(cant_read, @note)
        end
    end

    permissions :update? do
        it "Allows the owner to edit" do
            expect(subject).to permit(creator, @note)
        end
        it "Allows an admin to edit" do
            expect(subject).to permit(admin, @note)
        end
        it "does not allow a moderator to edit" do
            expect(subject).not_to permit(moderator, @note)
        end
        it "does not allow a reader to edit" do
            expect(subject).not_to permit(can_read, @note)
        end
        it "does not allow a non-reader to edit" do
            expect(subject).not_to permit(cant_read, @note)
        end
    end

    permissions :destroy? do
        it "Allows the owner to destroy" do
            expect(subject).to permit(creator, @note)
        end
        it "Allows an admin to destroy" do
            expect(subject).to permit(admin, @note)
        end
        it "does not allow a moderator to destroy" do
            expect(subject).not_to permit(moderator, @note)
        end
        it "does not allow a reader to destroy" do
            expect(subject).not_to permit(can_read, @note)
        end
        it "does not allow a non-reader to destroy" do
            expect(subject).not_to permit(cant_read, @note)
        end
    end

end
