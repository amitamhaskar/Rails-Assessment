class DataEncryptingKey < ActiveRecord::Base
  has_many :encrypted_strings
  
  attr_encrypted :key,
                 key: :key_encrypting_key

  validates :key, presence: true

  enum ROTATE_STATUS: {
    EMPTY: "No key rotation queued or in progress",
    QUEUED: "Key rotation has been queued",
    IN_PROGRESS: "Key rotation is in progress"
  }

  def self.primary
    find_by(primary: true)
  end

  def self.generate!(attrs={})
    create!(attrs.merge(key: AES.key))
  end

  def key_encrypting_key
    ENV['KEY_ENCRYPTING_KEY']
  end
end

