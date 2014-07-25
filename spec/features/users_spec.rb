require 'spec_helper'

def sign_in(user)
  visit root_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

feature 'Work as an admin' do
  scenario "adds a new client" do
    admin = create(:omron_client)
    sign_in(admin)
    expect{
      click_link 'New Client'
      fill_in 'First name', with: 'new'
      fill_in 'Last name', with: 'user'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'client_password', with: 'Secret123*'
      fill_in 'client_password_confirmation', with: 'Secret123*'
      click_button 'Create Client'
    }.to change(Client, :count).by(1)
   # HOW TO DO THIS? expect(current_path).to eq client_path(NEW USER I JUST CREATED)
  end
end

# feature 'Regular User' do
#   scenario "resets password" do
#     reg_user = create(:client, password: "Corre6t", password_confirmation: "Corre6t")
#     sign_in(reg_user)
#     click_link 'Profile'
#     click_link 'Change Password'
#     fill_in 'Current password', with: "Corre6t"
#     fill_in 'password', with: 'Newz33'
#     fill_in 'Password confirmation', with: 'Newz33'
#     click_button 'Update Client'

#     expect(page).to have_content 'Client was successfully updated.'
#   end
# end
