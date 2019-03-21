class TruncateTables < ActiveRecord::Migration
  def change
  	EncryptedString.delete_all
  	DataEncryptingKey.delete_all
  end
end
