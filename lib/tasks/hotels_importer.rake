desc "Import stuff"
task :import_hotels => :environment do
  HotelsImporter.import('/Users/craigmarksmith/Desktop/Edinburgh_Digs_Sheet.csv')
end

task :import_theatres => :environment do
  [
    {:name => 'Kings Theatre', :postcode => 'EH3 9LQ'},
    {:name => 'Playhouse Theatre', :postcode => 'EH1 3AA'},
    {:name => 'Festival Theatre', :postcode => 'EH8 9FT'}
  ].each do |theatre_attribute|
    Theatre.create!(theatre_attribute)
  end
end