require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "639121267448-mdv375k8ff2nac3bb1fhan57rko3ehaa.apps.googleusercontent.com", "Djlpe3_Ufh2aKPYcm3HIdtC9", {:redirect_path => "/oauth2callback"}
  
  
  importer :facebook, "629862104183921", "e20cdd15306020b4d1ca0b6f4ae6aa49"
end