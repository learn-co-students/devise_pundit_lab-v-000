# Feature: Create
#   As a normal user
#   I want to create a note
feature 'Create', :devise do

  # Scenario: User can't create a note
  #   Given I am signed in
  #   When I create a note
  #   Then I see my new note
  scenario 'user can create a note with content' do
    me = FactoryGirl.create(:user)
    login_as(me, :scope => :user)
    visit '/notes/new'
    fill_in 'Content', :with => 'gelato is the best'
    expect(page).to have_content me.notes.last
  end

end
