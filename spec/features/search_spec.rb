require 'spec_helper.rb'

feature "Looking up reports", js: true do
  scenario "finding reports" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end