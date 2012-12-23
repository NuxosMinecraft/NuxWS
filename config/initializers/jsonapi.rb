# Initialize JSONAPI

#if !defined?(::Rake)
#  puts "JSONAPI: Connecting"
#  jsonapi_config = YAML.load_file("#{Rails.root}/config/jsonapi.yml")
#  begin
#    JsonApi = JSONAPI::JSONAPI.new(jsonapi_config)
#  rescue Faraday::Error::ConnectionFailed
#    JsonApi = nil
#  end
#  puts "JSONAPI: Connected" if JsonApi
#end
# JSONAPI have been updated, all is fucked now.
JsonApi = nil
