class Mailing < ActiveRecord::Base
  attr_accessible :message, :subject, :user_id, :roles
  validates_presence_of :message, :subject, :roles
  belongs_to :user

  after_save :send_mailing

  def send_mailing
    # compute final roles list
    r = self.roles.split(" ").uniq
    users = []

    if r.include? "everybody"
      users = User.all
    else
      r.each do |role|
        User.find_all_by_role(Role.get_id(role.to_sym)).map{|z| users << z}
      end
    end

    puts "Will send mailing to : #{users.collect(&:login)}"
    Notifier.send_mailing_to_users(self, users)
  end
end
