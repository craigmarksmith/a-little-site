require 'test_helper'

class DigTest < ActiveSupport::TestCase
  def test_should_generate_a_hash_code
    dig = Dig.create!(:name => "Daves lovely old place" )
    assert dig.reload.hash_code
  end

  def test_should_only_allow_140_chars_for_landlords_notes
    dig = Dig.new(:name => "Daves lovely old place", :landlords_notes => random_string(150))
    assert !dig.valid?

    dig = Dig.new(:name => "Daves lovely old place", :landlords_notes => random_string(130))
    assert dig.valid?
  end

  def test_should_only_unlimited_chars_for_landlords_notes_when_is_a_member
    dig = Dig.new(:name => "Daves lovely old place", :member => true, :landlords_notes => random_string(150))
    assert dig.valid?
  end

private
  def random_string(length)
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse pretium, nisi sit amet fermentum rhoncus, purus est scelerisque tortor, a suscipit augue est ut nulla. Nulla id dui eu nisi fermentum aliquam. Donec vel venenatis neque. Etiam ac tortor quis felis pretium sodales et at magna. Aliquam erat volutpat. Integer scelerisque, mi a faucibus tempus, augue tellus semper nunc, ut vehicula tortor nisi a felis. Nulla ultricies consectetur erat, pellentesque scelerisque augue luctus non. Quisque nunc velit, adipiscing non egestas sed, commodo vitae ipsum. Vestibulum ullamcorper, nisl in bibendum tempor, ligula sem ultrices enim, ac accumsan augue lectus id turpis. Nunc eget neque quam. Fusce massa risus, sagittis in pulvinar non, elementum quis elit. Quisque magna nulla, rutrum non porta non, euismod at urna."[0...length]
  end
end