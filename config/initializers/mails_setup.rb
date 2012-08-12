if Rails.env != 'test'
  email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
  if email_settings["method"] != "smtp"
    ActionMailer::Base.delivery_method = :sendmail
    puts "Using sendmail for mails"
  else
    ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
    puts "Using SMTP for mails"
  end
end
