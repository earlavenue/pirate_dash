require 'spec_helper'

def sign_in(user)
  visit root_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

feature 'Create Client' do
  scenario "adds a new client" do
    admin = create(:omron_client)
    sign_in(admin)
    expect{
      click_link 'New Client'
      fill_in 'First name', with: 'new'
      fill_in 'Last name', with: 'user'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'client_password', with: 'secret123'
      fill_in 'client_password_confirmation', with: 'secret123'
      click_button 'Create Client'
    }.to change(Client, :count).by(1)
   # HOW TO DO THIS? expect(current_path).to eq client_path(NEW USER I JUST CREATED)
  end
end

feature "Work with Javascript" do
    background do
      client = create(:omron_client)
      sign_in(client)
    end

    scenario 'Does it show Edit?' do
      client2 = create(:client)
      click_link 'Clients'
      within "#client_#{client2.id}" do
        expect(page).to have_content 'Edit'
      end
    end
    scenario 'Shows correct Javascript data?' do
      client2 = create(:client)
      click_link 'Clients'
      within "#client_#{client2.id}" do
        expect(page).to have_content 'Edit'
      end
    end
  end

  #Test does upload show up on graph? In table? Does month show up in button when it should?
