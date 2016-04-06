describe "notes", type:  :feature do
  before do
    Note.destroy_all
    User.destroy_all
  end

  it "can create your own note" do
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    visit new_note_path(@note1)
    page.fill_in :content, :with => 'My New House'
    click_button('save')
    expect(page).to have_content("My New House")
  end
  
end