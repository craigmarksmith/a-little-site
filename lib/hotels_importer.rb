require 'fastercsv'
require 'pp'
class HotelsImporter

  def self.import(path)
    Dig.delete_all
    
    FasterCSV.foreach(path, :headers => :first_row) do |row|
      dig_attributes = {
        :name => row['Name'],
        :type => row['Type'],
        :building => row['Building'],
        :sleeps => row['Sleeps (up to)'],
        :number_of_twin_rooms => row['Twin'],
        :number_of_double_rooms => row['Double'],
        :number_of_single_rooms => row['Single'],
        :number_of_sofa_beds => row['Sofa bed'],
        :landlords_notes => row["Landlord's Notes"],
        :address_1 => row["Address 1"],
        :address_2 => row["Address 2"],
        :address_3 => row["Address 3"],
        :postcode => row["Postcode"],
        :landline => row["Landline"],
        :mobile => row["Mobile"],
        :fax => row["Fax"],
        :remarks => row["Remarks"]
      }
      
      Dig.create!(dig_attributes)
    end
  end

end
