Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_API_KEY'], ENV['LINKEDIN_SECRET_KEY']
  provider :stripe_connect, ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['STRIPE_SECRET_KEY'],
  :scope => 'read_write'
end