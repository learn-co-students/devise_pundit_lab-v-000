describe NotePolicy do
	subject { NotePolicy }

	let (:content) {FactoryGirl.build_stubbed :note}
	let (:other_user) {FactoryGirl.build_stubbed :user}
	let (:admin) {FactoryGirl.build_stubbed :user, :admin}

	let (:reader) {User.create(name: "mary", email: "mary@gamil.com", password: "catchingfish", role: 0)}
	let (:moderator) {User.create(name: "bob", email: "bob@gamil.com", password: "eatingfish", role: 2)}

	permissions :create? do
		it "it denies access if not owner" do
			expect(NotePolicy).not_to permit(other_user)
			expect(NotePolicy).not_to permit(admin)
			expect(NotePolicy).not_to permit(moderator)
		end
	end

	permissions :update? do
		it "prevents updates if not admin or owner"	do
			expect(NotePolicy).not_to permit(other_user)
			expect(NotePolicy).not_to permit(moderator)
		end
	end

	permissions :destroy? do
		it "prevents deleting notes if not admin or owner" do
			expect(NotePolicy).not_to permit(other_user)
			expect(NotePolicy).not_to permit(moderator)
		end
	end

	permissions :show? do
		it "prevents viewing notes if other user" do
			expect(NotePolicy).not_to permit(other_user)	
		end

		it "allows viewing notes if reader" do
			expect(NotePolicy).to permit(reader)	
		end	
	end	
end		
