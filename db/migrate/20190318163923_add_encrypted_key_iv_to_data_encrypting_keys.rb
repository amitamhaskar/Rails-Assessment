class AddEncryptedKeyIvToDataEncryptingKeys < ActiveRecord::Migration
  def change
    add_column :data_encrypting_keys, :encrypted_key_iv, :string, unique: true, index: true
  end
end
