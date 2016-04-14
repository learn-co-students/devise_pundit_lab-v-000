include Warden::Test::Helpers
Warden.test_mode!


feature "Note new", :devise do

  build_notes

  after(:each) do
    Warden.test_reset!
  end

  scenario 'Users must be logged in to create notes' do
    visit new_note_path
    expect(page).not_to raise_error

  end





end
