describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  # permissions :create? do
  #  it 'allows user to create a note' do
  #    expect(subject).to permit(current_user)
  #  end
  # end

  permissions :update? do
    # it 'allows a user to edit thier own posts' do
    #  expect(subject).to permit(current_user)
    # end
    it 'allows an admin to edit a post' do
      expect(subject).to permit(admin)
    end
    it 'prevents a user from editing a post that they did not create' do
      expect(subject).not_to permit(other_user)
    end
  end


end
