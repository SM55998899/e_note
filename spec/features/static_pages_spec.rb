require 'rails_helper'

describe 'home' do 
  specify '画面の表示' do
    visit root_path
    expect(page).to have_css('a', text: 'e-note')
    expect(page).to have_selector('a', count: 15)
  end
end

describe 'help' do 
  specify '画面の表示' do
    visit help_path
    expect(page).to have_css('a', text: 'e-note')
    expect(page).to have_selector('a', count: 7)
  end
end

describe 'diary' do 
  specify '画面の表示' do
    visit diary_path
    expect(page).to have_css('a', text: 'e-note')
  end
end

describe 'regist' do 
  specify '画面の表示' do
    visit regist_path
    expect(page).to have_css('a', text: 'e-note')
  end
end
