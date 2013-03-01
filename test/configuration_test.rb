require 'test_helper'

class VivaldiConfigurationTest < Test::Unit::TestCase
  def test_allows_configuration_with_block
    result = nil
    Vivaldi.configure do |config|
      result = config
    end
    assert_equal result, Vivaldi.configuration
  end
end
