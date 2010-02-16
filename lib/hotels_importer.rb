require 'fastercsv'
class HotelsImporter

  def self.import(path)
    Dig.delete_all

    FasterCSV.foreach(path, :headers => :first_row) do |row|
      dig_attributes = {}
      dig_attributes[:name] = row['Name'] if row['Name']
      dig_attributes[:sleeps] = row['Sleeps (up to)'] if row['Sleeps (up to)']
      dig_attributes[:number_of_twin_rooms] = row['Twin'] if row['Twin']
      dig_attributes[:number_of_double_rooms] = row['Double'] if row['Double']
      dig_attributes[:number_of_single_rooms] = row['Single'] if row['Single']
      dig_attributes[:number_of_sofa_beds] = row['Sofa bed'] if row['Sofa bed']
      dig_attributes[:landlords_notes] = row["Landlord's Notes"] if row["Landlord's Notes"]
      dig_attributes[:address_1] = row['Address 1'] if row['Address 1']
      dig_attributes[:address_2] = row['Address 2'] if row['Address 2']
      dig_attributes[:address_3] = row['Address 3'] if row['Address 3']
      dig_attributes[:postcode] = row['Postcode'] if row['Postcode']
      dig_attributes[:landline] = row['Landline'] if row['Landline']
      dig_attributes[:mobile] = row['Mobile'] if row['Mobile']
      dig_attributes[:fax] = row['Fax'] if row['Fax']
      dig_attributes[:remarks] = row['Remarks'] if row['Remarks']

      dig = Dig.new(dig_attributes)
      
      dig.dig_types << DigType.find_by_name('Living with Landlord') if row['Living with Landlord'] == '1'
      dig.dig_types << DigType.find_by_name('Self Contained Accom') if row['Self Contained Accom'] == '1'

      dig.save!
    end
  end

end
