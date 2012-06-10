class ValidateMinecraftLoginAndNotHackedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.nil?
      # Check using minecraft's server stuff
      # http://www.minecraft.net/haspaid.jsp?user=#{USERNAME}
      require "open-uri"
      begin
        haspaid = open("http://www.minecraft.net/haspaid.jsp?user=#{value}").read
        if haspaid != "true"
          record.errors[attribute] << "Apparently the user '#{value}' doesn't have paid his minecraft copy, sorry."
        end
      rescue
        record.errors[attribute] << "Can't get response from minecraft.net, contact NuxWS admin"
      end
    end
  end
end