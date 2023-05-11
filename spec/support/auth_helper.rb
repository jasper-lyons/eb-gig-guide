module AuthHelper
  def http_basic_login
    page.driver.browser.authorize('test', 'test')
  end
end

ENV['ADMIN_NAME'] = 'test'
ENV['ADMIN_PASSWORD'] = 'test'
