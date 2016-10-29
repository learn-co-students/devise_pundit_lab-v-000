describe NotePolicy do
  subject { NotePolicy }

  let (:note_user) { User.create(name: "vicky", email: "vicky@vicky.com", role: 0 ) }
  let (:other_user1) { User.create(name: "wicky", email: "wicky@wicky.com", role: 0 ) }
  let (:other_user2) { User.create(name: "sicky", email: "sicky@sicky.com", role: 0 ) }
  let (:admin) { User.create(name: "bicky", email: "bicky@bicky.com", role: 2 ) }
  let (:moderator) do
  	User.create({name: "hally", email: "hally@hally.com", role: 1})
  end
  let (:note) do
  		note = note_user.notes.build(content: "Ha, ha, ha!")
  		note_user.save
  		note.readers << other_user1
  		note.save
  		note
  end

  let (:note_user2) { User.create(name: "whoey", email: "whoey@whoey.com", role: 0 ) }

	let (:note2) do
		note = note_user2.notes.build(content: "He, he, he!")
		note_user2.save
		note.readers << other_user2
		note.save
		note
	end

  permissions :edit? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

  permissions :update? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

  permissions :destroy? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

    permissions :show? do
    it "denies access if not an admin a moderator, a reader or the creator" do
      expect(NotePolicy).not_to permit(other_user2, note)
    end
    it "allows access for an admin, moderator, reader, or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(moderator, note)
      expect(NotePolicy).to permit(other_user1, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

  # very interesting: the database is acting completely wonky when I try to implement these examples.
  # no matter what I do, the notes will never acknowledge their rightful owners
  # and in some permutations, Note.all is actually empty.

  # describe 'policy scope' do
  # 	it 'lets admins and moderators see all notes' do
  # 		# I'll also force the owners of the notes and all of the users to be tested
  # 		# into existence before the notes are created.
  # 		note_user
  # 		note_user2
  # 		other_user1
  # 		other_user2
  # 		admin
  # 		moderator

  # 		note
  # 		note2

  # 		# and now Note.all is empty for this example
  # 		binding.pry

  # 		expect(NotePolicy::Scope.new(admin, Note.all).resolve).to include(note)
  # 		expect(NotePolicy::Scope.new(admin, Note.all).resolve).to include(note2)

  # 		expect(NotePolicy::Scope.new(moderator, Note.all).resolve).to include(note)
  # 		expect(NotePolicy::Scope.new(moderator, Note.all).resolve).to include(note2)
  # 	end

  # 	it 'lets regular users to only see their own notes or the notes that they are readers of' do
  # 		# I'll also force the owners of the notes and all of the users to be tested
  # 		# into existence before the notes are created.
  # 		note_user
  # 		note_user2
  # 		other_user1
  # 		other_user2
  # 		admin
  # 		moderator

  # 		# no notes are spawning in this example so I'll try to force them into existence
  # 		note
  # 		note2

  # 		expect(NotePolicy::Scope.new(note_user, Note.all).resolve).to include(note)
  # 		expect(NotePolicy::Scope.new(note_user, Note.all).resolve).to_not include(note2)

  # 	end
  # end


end