class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    from = Settings.app_conf_mail_from
    to = "#{user.login} <#{user.email}>"
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token, :host => Settings.app_conf_host)
    mail(:to => to,
         :subject => "Password Reset",
         :from => from,
         :fail_to => from
   ).deliver do |format|
      format.text
    end
  end

  def register_notify_user(user)
    from = Settings.app_conf_mail_from
    to = "#{user.login} <#{user.email}>"
    @user = user
    @user_url = user_url(user.id, :host => Settings.app_conf_host)
    mail(:to => to,
      :subject => "Registered on http://nuxos-minecraft.fr/",
      :from => from,
      :fail_to => from
    ).deliver do |format|
      format.text
    end
  end

  def register_notify_admins(user)
    admins = User.where{role >= Role.get_id(:moderator)}
    from = Settings.app_conf_mail_from
    admins_formatted = admins.map{|a| "#{a.login} <#{a.email}>"}
    admins_formatted.each do |adm|
      @user = user
      @user_url = user_url(user.id, :host => Settings.app_conf_host)
      mail(:to => adm,
        :subject => "New user #{user.login} registered on http://nuxos-minecraft.fr/",
        :from => from,
        :fail_to => from
      ).deliver do |format|
        format.text
      end
    end
  end

  def pm_notify_user(pm)
    user = User.find(pm.to)
    from = Settings.app_conf_mail_from
    to = "#{user.login} <#{user.email}>"
    @user = user
    @pm = pm
    @pm_url = pm_url(pm.id, :host => Settings.app_conf_host)
    mail(:to => to,
      :subject => "You received a personnal message from #{pm.user.login}",
      :from => from,
      :fail_to => from
    ).deliver do |format|
      format.text
    end
  end

  def notify_users_topic_update(message, notif_user)
    from = Settings.app_conf_mail_from
    to = "#{notif_user.login} <#{notif_user.email}>"
    @user = message.user
    @message_url = forum_topic_url(message.topic.forum, message.topic, :host => Settings.app_conf_host)
    mail(:to => to,
      :subject => "Reply to a topic: #{message.topic.title}",
      :from => from,
      :fail_to => from
    ).deliver do |format|
      format.text
    end
  end

  def send_mailing_to_users(mailing, users)
    users.each do |user|
      from = Settings.app_conf_mail_from
      to = "#{user.login} <#{user.email}>"
      @mailing = mailing
      mail(:to => to,
        :subject => "Message from Nuxos Minecraft: #{mailing.subject}",
        :from => from,
        :fail_to => from
      ).deliver do |format|
        format.text
      end
    end
  end
end
