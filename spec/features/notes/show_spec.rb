describe "notes", type:  :feature do
  before do
    Note.destroy_all
    User.destroy_all
  end

  it "can view your own note" do
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    @note1 = user1.notes.build(content: "Note 1")
    @note1.save
    visit note_path(@note1)
    expect(page).to have_content("Note 1")
  end
  
   it "can not view a note you are a reader of" do
    @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    @note1 = @user.notes.build(content: "Note 1")
    @note1.save
    visit note_path(@note1)
    expect(page).to have_content("Access denied.")
  end
  
  it "can view a note you are a reader of" do
    @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    user1 = FactoryGirl.create(:user)
    signin(user1.email, user1.password)
    @note1 = @user.notes.build(content: "Note 1")
    @note1.readers << user1
    @note1.save
    visit note_path(@note1)
    expect(page).to have_content("Note 1")
  end
  
  it "admin can view any note" do
    @user = User.create(name: "A",email: "A@a.com",password: "AAAAAAAAAA")
    user1 = FactoryGirl.create(:user, :admin)
    signin(user1.email, user1.password)
    @note1 = @user.notes.build(content: "Note 1")
    @note1.readers << user1
    @note1.save
    visit note_path(@note1)
    expect(page).to have_content("Note 1")
  end
  
end