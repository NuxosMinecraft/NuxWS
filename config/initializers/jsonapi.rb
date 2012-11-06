# Initialize JSONAPI

jsonapi_config = YAML.load_file("#{Rails.root}/config/jsonapi.yml")
begin
  JsonApi = JSONAPI::JSONAPI.new(jsonapi_config)
rescue Faraday::Error::ConnectionFailed
  JsonApi = nil
end
puts "JSONAPI: Connected" if JsonApi
