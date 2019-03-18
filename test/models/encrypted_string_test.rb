require 'test_helper'

class EncryptedStringTest < ActiveSupport::TestCase

  test "reencrypt!" do
  	# Create an encrypted string
    encrypted_string = EncryptedString.create!(value: "Test string")
    
    # Generate a new primary key
    DataEncryptingKey.generate_new_primary
    new_key = DataEncryptingKey.primary
    # reencrypt with the new primary key
    encrypted_string.reencrypt!(new_key)

    # make sure the data encrypting key is the new one
    assert_equal new_key.id, encrypted_string.data_encrypting_key.id
    # make sure the original string can be retrieved.
    assert_equal "Test string", encrypted_string.value
  end

  test "create" do
  	assert_difference "EncryptedString.count" do
      encrypted_string = EncryptedString.create!(value: "Test string")
      assert encrypted_string.token
      assert encrypted_string.data_encrypting_key
    end
  end

  test "re_encrypt_all" do
  	# Create 2 encrypted strings
    encrypted_string1 = EncryptedString.create!(value: "Test string 1")
    encrypted_string2 = EncryptedString.create!(value: "Test string 2")
 
    token1 = encrypted_string1.token
    token2 = encrypted_string2.token

    # Generate a new primary key
    DataEncryptingKey.generate_new_primary
    new_key = DataEncryptingKey.primary

    # reencrypt all strings with the new primary key
    EncryptedString.re_encrypt_all(new_key)

    # Get the string 1
    encrypted_string = EncryptedString.find_by(token: token1)
    # make sure the data encrypting key is the new one
    assert_equal new_key.id, encrypted_string.data_encrypting_key.id
    # make sure the original string can be retrieved.
    assert_equal "Test string 1", encrypted_string.value

    # Get the string 2
    encrypted_string = EncryptedString.find_by(token: token2)
    # make sure the data encrypting key is the new one
    assert_equal new_key.id, encrypted_string.data_encrypting_key.id
    # make sure the original string can be retrieved.
    assert_equal "Test string 2", encrypted_string.value
  end
end
