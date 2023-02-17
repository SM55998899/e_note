require 'rails_helper'

describe 'home' do 
  specify '画面の表示' do
    visit root_path
    expect(page).to have_css('a', text: 'e-note')
  end
end

describe 'help' do 
  specify '画面の表示' do
    visit help_path
    expect(page).to have_css('a', text: 'e-note')
  end
end
