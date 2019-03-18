class DataEncryptingKey < ActiveRecord::Base
  has_many :encrypted_strings
  
  attr_encrypted :key,
                 key: :key_encrypting_key

  validates :key, presence: true

  def self.primary
    primary_key = find_by(primary: true)
    if primary_key.nil?
      primary_key = DataEncryptingKey.generate!(primary: true)
    end
    primary_key
  end

  def self.generate!(attrs={})
    create!(attrs.merge(key: AES.key))
  end

  def key_encrypting_key
    ENV['KEY_ENCRYPTING_KEY']
  end
end

