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
    # make sure that the old primary has primary false
    assert_equal false, DataEncryptingKey.find(key.id).primary
    # make sure the last key has the primary true (new primary)
    assert_equal true, DataEncryptingKey.last.primary
    # make sure the id of old and new primary keys is different
    assert_not_equal key.id, DataEncryptingKey.primary.id
  end
end
