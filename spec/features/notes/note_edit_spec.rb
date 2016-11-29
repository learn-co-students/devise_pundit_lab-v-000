feature 'Delete note', :devise do
  before(:each) do
    @user = User.create(confirmed_at: Time.now, name: "test", email: 'user@example.com', password: "passwordy")
    @note = @user.notes.create(content: "some content")
    @mod = User.create(confirmed_at: Time.now, name: "mod", email: "mod@admin.com", password: "passwordy", role: 1)
    @admin = User.create(confirmed_at: Time.now, name: "admin", email: "admin@admin.com", password: "passwordy", role: 2)
    @other_note = @admin.notes.create(content: "invisible content")
  end

  scenario 'user can update their own note' do
    signin(@user.email, @user.password)
    visit edit_note_path(@note)
    fill_in :note_content, with: 'something else!'
    click_button 'save'
    expect(page).to have_content 'something else!'
  end

  scenario 'admin can update any note' do
    signin(@admin.email, @admin.password)
    visit edit_note_path(@note)
    fill_in :note_content, with: 'something else!'
    click_button 'save'
    expect(page).to have_content 'something else!'
  end
end
