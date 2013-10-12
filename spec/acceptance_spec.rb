require 'spec_helper'
require 'capybara'

include Capybara::DSL
Capybara.current_driver = :selenium
Capybara.app_host = 'http://www.google.com'

describe "Dashboards" do
  describe "Welcome Widget" do
    it "should have the content" do
      visit '/'
      page.should have_content('Random Content.')
    end
  end
end
