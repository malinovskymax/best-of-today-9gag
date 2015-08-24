require 'rails_helper'

describe 'View best of 9gag posts on main page', type: :feature, js: true do
  before do
    visit root_path
  end

  it 'should render at least header and footer' do
    expect(page).to have_content("Best of today's 9gag")
    expect(page).to have_link('Max Malinovsky')
  end

  it 'should redirect to main page from every other page' do
    visit '/wrong_page'
    expect(page).to have_content("Best of today's 9gag")
    expect(page).to have_link('Max Malinovsky')
  end

#   TODO other tests

end