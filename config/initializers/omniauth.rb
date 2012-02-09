Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'da671307795b73d81c4f', '34951e536dabcea63fe33fc26339df52bbda474d'
end