require "rails_helper"

feature "user creates account" do
  scenario "with valid info" do
    visit sign_up_path

    fill_in "user[name]", with: "Muffin"
    fill_in "user[email]", with: "muffin@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Create Account"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, Muffin")
    expect(page).to have_link("Logout")
  end

  scenario "with invalid info" do
    visit sign_up_path

    fill_in "user[name]", with: "Muffin"
    fill_in "user[email]", with: "muffin@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "bananas"
    click_on "Create Account"

    expect(find(".flash")).to have_content("Invalid account information")
    expect(current_path).to eq(users_path)
    expect(page).to_not have_content("Welcome, Muffin")
  end
end

feature "deletes account" do
  let(:user) { Fabricate(:user) }
  scenario "they click delete" do
    login(user)
    visit user_path(user)

    expect {
      click_on("Delete Account")
    }.to change { User.count }.from(1).to(0)
    expect(current_path).to eq(root_path)
  end
end
