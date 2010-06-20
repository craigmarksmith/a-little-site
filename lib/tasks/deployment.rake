desc "Deploy to staging"
task :deploy do
  p "deploying to staging"
  system('git push heroku-staging master')

  p "running migrations"
  system('heroku rake db:migrate --app theatredigsbooker-staging')

  p "restarting app"
  system('heroku restart --app theatredigsbooker-staging')
end

desc "Deploy to LIVE"
task :deploy_to_live do
  p "Are you sure you want to deploy to LIVE? Please type 'YES' if you are."

  exit unless STDIN.gets.chomp == "YES"

  p "deploying to LIVE"
  system('git push heroku master')

  p "running migrations"
  system('heroku rake db:migrate')

  p "restarting app"
  system('heroku restart')
end