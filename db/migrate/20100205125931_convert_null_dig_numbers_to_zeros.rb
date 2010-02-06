class ConvertNullDigNumbersToZeros < ActiveRecord::Migration
  def self.up
    change_column_default :digs, :number_of_twin_rooms, 0
    change_column_default :digs, :number_of_double_rooms, 0
    change_column_default :digs, :number_of_single_rooms, 0
    change_column_default :digs, :number_of_sofa_beds, 0
    change_column_default :digs, :sleeps, 0
  end

  def self.down
    change_column_default :digs, :number_of_twin_rooms, nil
    change_column_default :digs, :number_of_double_rooms, nil
    change_column_default :digs, :number_of_single_rooms, nil
    change_column_default :digs, :number_of_sofa_beds, nil
    change_column_default :digs, :sleeps, nil
  end
end
