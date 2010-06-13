desc "Deploy to staging"
task :deploy do
  p "deploying to staging"
  system('git push heroku-staging master')
  
  p "running migrations"
  system('heroku rake db:migrate --app theatredigsbooker-staging')
  
  p "restarting app"
  system('heroku restart --app theatredigsbooker-staging')
end