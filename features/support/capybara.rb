Capybara.register_driver :safari do |app|
  Capybara::Selenium::Driver.load_selenium
  Capybara::Selenium::Driver.new app, browser: :safari
end

Capybara.default_driver = ENV['SELENIUM_DRIVER']&.to_sym || :selenium_chrome_headless
