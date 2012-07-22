class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    from = "App FIXME <noreply@example.com>"
    to = "#{user.login} <#{user.email}>"
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => to,
         :subject => "Password Reset",
         :from => from,
         :fail_to => from
   ) do |format|
      format.text
    end
    puts edit_password_reset_url(user.perishable_token)
  end
end
