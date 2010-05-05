require 'fastercsv'
class HotelsImporter

  def self.import(path)
    # Dig.delete_all
    # TheatreDistance.delete_all

    FasterCSV.open(path, :headers => :first_row) do |csv|
      csv.each do |row|
        dig = Dig.new(dig_attributes(row))

        dig.dig_types << DigType.find_by_name('Living with Landlord') if row['Living with Landlord'] == '1'
        dig.dig_types << DigType.find_by_name('Self Contained Accom') if row['Self Contained Accom'] == '1'

        if dig.valid?
          dig.save!
        else
          p dig.errors.full_messages
          p "On line #{csv.lineno}"
          next
        end

        {
          'Walking Distance (miles) from Kings Theatre EH3 9LQ' => Theatre.find_by_name('Kings Theatre'),
          'Walking Distance  (miles) from Playhouse Theatre      EH1 3AA' => Theatre.find_by_name('Playhouse Theatre'),
          'Walking Distance (miles) from Festival Theatre EH8 9FT' => Theatre.find_by_name('Festival Theatre')
        }.each do |column_name, theatre|
          TheatreDistance.create!(:distance => row[column_name].to_f, :theatre_id => theatre.id, :dig_id => dig.id) if row[column_name]
        end
      end
    end
  end

  def self.dig_attributes(row)
    landlords_notes = "Landlord's Notes                                           whb=wash hand basin, ph=phone, fx=fax, wc=loo, wm=washing machine, mw=microwave, ff=fridgefreezer, dw=dishwasher "

    dig_attributes = {}
    dig_attributes[:name] = row['Name'] if row['Name']
    dig_attributes[:sleeps] = row['Sleeps (up to)'] if row['Sleeps (up to)']
    dig_attributes[:number_of_twin_rooms] = row['Twin'] if row['Twin']
    dig_attributes[:number_of_double_rooms] = row['Double'] if row['Double']
    dig_attributes[:number_of_single_rooms] = row['Single'] if row['Single']
    dig_attributes[:number_of_sofa_beds] = row['Sofa bed'] if row['Sofa bed']
    dig_attributes[:landlords_notes] = row[landlords_notes] if row[landlords_notes]
    dig_attributes[:address_1] = row['Address 1'] if row['Address 1']
    dig_attributes[:address_2] = row['Address 2'] if row['Address 2']
    dig_attributes[:address_3] = row['Address 3'] if row['Address 3']
    dig_attributes[:postcode] = row['Postcode'] if row['Postcode']
    dig_attributes[:landline] = row['Landline'] if row['Landline']
    dig_attributes[:mobile] = row['Mobile'] if row['Mobile']
    dig_attributes[:fax] = row['Fax'] if row['Fax']
    dig_attributes[:price_per_week_from] = (row['Price Per Week         (7 nights)FROM      £'].sub('£','').to_f * 100).to_i if row['Price Per Week         (7 nights)FROM      £']

    dig_attributes
  end

end
