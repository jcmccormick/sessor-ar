require 'spec_helper.rb'

feature "Viewing a report", js: true do
  before do
    Report.create!(name: 'Baked Potato w/ Cheese', 
           submission: "nuke for 20 minutes")

    Report.create!(name: 'Baked Brussel Sprouts',
           submission: 'Slather in oil, and roast on high heat for 20 minutes')
  end
  scenario "view one report" do
    visit '/'
    fill_in "keywords", with: "baked"
    click_on "Search"

    click_on "Baked Brussel Sprouts"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("Slather in oil")

    click_on "Back"

    expect(page).to     have_content("Baked Brussel Sprouts")
    expect(page).to_not have_content("Slather in oil")
  end
end