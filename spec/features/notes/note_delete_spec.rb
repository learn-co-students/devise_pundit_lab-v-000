feature 'Delete note', :devise do
  before(:each) do
    @user = User.create(confirmed_at: Time.now, name: "test", email: 'user@example.com', password: "passwordy")
    @note = @user.notes.create(content: "some content")
    @mod = User.create(confirmed_at: Time.now, name: "mod", email: "mod@admin.com", password: "passwordy", role: 1)
    @admin = User.create(confirmed_at: Time.now, name: "admin", email: "admin@admin.com", password: "passwordy", role: 2)
    @other_note = @admin.notes.create(content: "invisible content")
  end

  scenario 'user can delete their own note' do
    signin(@user.email, @user.password)
    visit edit_note_path(@note)
    click_button "Delete Note"
    expect(Note.find_by(id: @note.id)).to be(nil)
  end

  scenario "admin can delete someone else's note" do
    signin(@admin.email, @admin.password)
    visit edit_note_path(@note)
    click_button "Delete Note"
    expect(Note.find_by(id: @note.id)).to be(nil)
  end
end
