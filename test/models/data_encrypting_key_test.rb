require 'test_helper'

class DataEncryptingKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test ".generate!" do
    assert_difference "DataEncryptingKey.count" do
      key = DataEncryptingKey.generate!
      assert key
    end
  end

  test "primary" do
    key = DataEncryptingKey.primary
    assert key
  end

  test "generate_new_primary" do 
  	key = DataEncryptingKey.primary
    DataEncryptingKey.generate_new_primary
    assert_equal false, DataEncryptingKey.find(key.id).primary
    assert_equal true, DataEncryptingKey.last.primary
  end
end
