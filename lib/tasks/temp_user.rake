desc "Create a temp users"
task :create_admin_user => :environment do
  User.create!(:username => 'admin', :password => 'password', :password_confirmation => 'password')
end