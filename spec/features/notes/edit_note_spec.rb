feature 'Edit note', :devise do

  before(:each) do
    @user = User.create(confirmed_at: Time.now, name: "test", email: 'user@example.com', password: "passwordy")
    @note = @user.notes.create(content: "some content")
    @mod = User.create(confirmed_at: Time.now, name: "mod", email: "mod@admin.com", password: "passwordy", role: 1)
    @admin = User.create(confirmed_at: Time.now, name: "admin", email: "admin@admin.com", password: "passwordy", role: 2)
    @other_note = @admin.notes.create(content: "invisible content")
  end

  scenario 'user can edit their own note' do
    signin(@user.email, @user.password)
    visit edit_note_path(@note)
    fill_in :note_content, with: "different content!"
    click_button "save"
    expect(page).to have_content "different content!"
  end

  scenario "user cannot edit someone else's note" do
    signin(@user.email, @user.password)
    visit edit_note_path(@other_note)
    expect(page).to have_content "Welcome"
  end

  scenario "mod cannot edit someone else's note" do
    signin(@mod.email, @mod.password)
    visit edit_note_path(@note)
    expect(page).to have_content "Welcome"
  end

  scenario "admin can edit someone else's note" do
    signin(@admin.email, @admin.password)
    visit edit_note_path(@note)
    fill_in :note_content, with: "different content!"
    click_button "save"
    expect(Note.find(@note.id).content).to eq("different content!")
  end

end
