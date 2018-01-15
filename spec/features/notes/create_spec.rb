
feature 'Create Note', :devise do

  scenario 'user can create a note owned by himself' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    click_link 'New Note'
    fill_in 'Content', :with => 'A secret test note'
    click_button 'save'
    expect(page).to have_content 'A secret test note'
    expect(page).to have_content 'visible to ' + user.name
  end

  scenario 'user can create a note viewable by another' do
    user = FactoryGirl.create(:user)
    another_user = FactoryGirl.create(:user, :another)
    signin(user.email, user.password)
    click_link 'New Note'
    fill_in 'Content', :with => 'A secret test note'
    fill_in 'Visible to', :with => another_user.name
    click_button 'save'
    expect(page).to have_content 'A secret test note'
    expect(page).to have_content 'visible to ' + another_user.name
  end


end
