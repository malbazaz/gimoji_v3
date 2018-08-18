Rails.application.config.middleware.use OmniAuth::Builder do
  provide :facebook, ENV['FACEBOOK_KEY'],ENV['FACEBOOK_SECRET']
end