require "rails_helper"

feature "user authentication" do
  let(:user) { Fabricate(:user) }
  scenario "user logs in" do
    visit login_path

    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    click_button("Login")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_link("Logout")
  end
end
