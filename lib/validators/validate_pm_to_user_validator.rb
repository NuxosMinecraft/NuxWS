class ValidatePmToUserValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.nil?
      user = User.find_by_id(value)
      if !user or user.nil?
        record.errors[attribute] << "User '#{value}' doesn't exist !"
      end
    end
  end
end
