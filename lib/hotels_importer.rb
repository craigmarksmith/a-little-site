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

    mappings = {
      :name => 'Name',
      :sleeps => 'Sleeps (up to)',
      :building => 'Building',
      :price_per_night => 'Price Per Night            £',
      :price_per_week => 'Price Per Week          £',
      :number_of_twin_rooms => 'Twin',
      :number_of_double_rooms => 'Double',
      :number_of_single_rooms => 'Single',
      :number_of_sofa_beds => 'Sofa bed',
      :landlords_notes => landlords_notes,
      :address_1 => 'Address 1',
      :address_2 => 'Address 2',
      :address_3 => 'Address 3',
      :postcode => 'Postcode',
      :landline => 'Landline',
      :mobile => 'Mobile',
      :fax => 'Fax'
    }

    dig_attributes = mappings.inject({}) do |acc, (k,v)|
      acc[k] = row[v] if row[v]
      acc
    end
    dig_attributes[:price_per_week_from] = (row['Price Per Week         (7 nights)FROM      £'].sub('£','').to_f * 100).to_i if row['Price Per Week         (7 nights)FROM      £']

    dig_attributes
  end

end
