require 'spec_helper.rb'

feature "Looking up reports", js: true do
  before do
    Report.create!(name: 'Baked Potato w/ Cheese')
    Report.create!(name: 'Garlic Mashed Potatoes')
    Report.create!(name: 'Potatoes Au Gratin')
    Report.create!(name: 'Baked Brussel Sprouts')
  end
  scenario "finding reports" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    expect(page).to have_content("Baked Potato")
    expect(page).to have_content("Baked Brussel Sprouts")
  end
end