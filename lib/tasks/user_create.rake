begin
  namespace :user do
    task :create => :environment do
      puts "You will be prompted to enter a login, email address and password for the new ADMIN user"
      print "Enter a login: "
      login = STDIN.gets
      print "Enter an email address: "
      email = STDIN.gets
      print "Enter a password: "
      password = STDIN.gets
      unless login.strip!.blank? || email.strip!.blank? || password.strip!.blank?
        if User.create(:login => login, :email => email, :password => password, :password_confirmation => password, :role => Role.get_id(:admin))
          puts "The user was created successfully."
        else
          puts "Sorry, the user was not created!"
        end
      end
    end
  end
end
