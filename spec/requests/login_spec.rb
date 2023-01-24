# require "json"
# require "selenium-webdriver"
# require "rspec"
# include RSpec::Expectations

# describe "LogIn" do

#   before(:each) do
#     @driver = Selenium::WebDriver.for :firefox
#     @base_url = "https://www.google.com/"
#     @accept_next_alert = true
#     @driver.manage.timeouts.implicit_wait = 30
#     @verification_errors = []
#   end
  
#   after(:each) do
#     @driver.quit
#     @verification_errors.should == []
#   end
  
#   it "test_log_in" do
#     @driver.find_element(:link, "Вход").click
#     @driver.find_element(:name, "user[password]").clear
#     @driver.find_element(:name, "user[password]").send_keys "12345678"
#     @driver.find_element(:id, "email-field").clear
#     @driver.find_element(:id, "email-field").send_keys "user3@gmail.com"
#     @driver.find_element(:id, "custom-btn").click
#     @driver.find_element(:link, "GO 🥁").click
#   end
  
#   def element_present?(how, what)
#     ${receiver}.find_element(how, what)
#     true
#   rescue Selenium::WebDriver::Error::NoSuchElementError
#     false
#   end
  
#   def alert_present?()
#     ${receiver}.switch_to.alert
#     true
#   rescue Selenium::WebDriver::Error::NoAlertPresentError
#     false
#   end
  
#   def verify(&blk)
#     yield
#   rescue ExpectationNotMetError => ex
#     @verification_errors << ex
#   end
  
#   def close_alert_and_get_its_text(how, what)
#     alert = ${receiver}.switch_to().alert()
#     alert_text = alert.text
#     if (@accept_next_alert) then
#       alert.accept()
#     else
#       alert.dismiss()
#     end
#     alert_text
#   ensure
#     @accept_next_alert = true
#   end
# end
