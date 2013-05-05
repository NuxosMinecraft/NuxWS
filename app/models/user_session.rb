class UserSession < Authlogic::Session::Base

  # Emulate this function to avoid the super-classing of the formbuilder to cry
  def self.validators_on(something)
    return [ActiveModel::Validations::PresenceValidator]
  end
end
