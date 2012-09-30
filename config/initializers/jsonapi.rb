# Initialize JSONAPI

jsonapi_config = YAML.load_file("#{Rails.root}/config/jsonapi.yml")
JsonApi = JSONAPI::JSONAPI.new(jsonapi_config)
puts "JSONAPI: Connected" if JsonApi
