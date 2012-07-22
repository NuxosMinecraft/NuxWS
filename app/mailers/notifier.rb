class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    from = Settings.app_conf_mail_from
    to = "#{user.login} <#{user.email}>"
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token, :host => Settings.app_conf_host)
    mail(:to => to,
         :subject => "Password Reset",
         :from => from,
         :fail_to => from
   ) do |format|
      format.text
    end
  end
end
