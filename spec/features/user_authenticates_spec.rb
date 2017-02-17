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

  scenario "user inputs invalid info" do
    visit login_path

    fill_in("Email", with: user.email)
    fill_in("Password", with: "Banana")

    click_button("Login")

    expect(find(".flash")).to have_content("Invalid email or password")
  end

  scenario "user logs out" do
    visit login_path

    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    click_button("Login")
    click_on("Logout")
    expect(current_path).to eq(login_path)
    expect(page).to_not have_content(user.name)
  end
end
