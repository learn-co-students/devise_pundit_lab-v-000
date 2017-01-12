describe "notes", type:  :feature do
  before do
    Note.destroy_all
    User.destroy_all
  end

  it "can update your own note" do
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    @note1 = user1.notes.build(content: "Note 1")
    @note1.save
    visit edit_note_path(@note1)
    page.fill_in :content, :with => 'My New House'
    click_button('save')
    expect(page).to have_content("My New House")
  end
  
  it "cannot update another user's note" do
     @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    @note1 = @user.notes.build(content: "Note 1")
    @note1.save
    visit edit_note_path(@note1)
    page.fill_in :content, :with => 'My New House'
    click_button('save')
    expect(page).to have_content("Access denied.")
  end
  
  it "admin can update any note" do
    @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    user1 = FactoryGirl.create(:user,:admin)
    signin(user1.email, user1.password)
    @note1 = @user.notes.build(content: "Note 1")
    @note1.save
    visit edit_note_path(@note1)
    page.fill_in :content, :with => 'My New House'
    click_button('save')
    expect(page).to have_content("My New House")
  end
  
end