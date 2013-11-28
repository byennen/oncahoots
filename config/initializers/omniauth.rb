Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_API_KEY'], ENV['LINKEDIN_SECRET_KEY'], :scope => 'r_fullprofile r_emailaddress r_contactinfo'
  provider :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET_KEY'],
  :scope => 'read_write'
end

LinkedIn.configure do |config|
  config.token = ENV['LINKEDIN_API_KEY']
  config.secret = ENV['LINKEDIN_SECRET_KEY']
end