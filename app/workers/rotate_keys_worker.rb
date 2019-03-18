class RotateKeysWorker
  include Sidekiq::Worker

  # Set sidekiq retry false since we do not want
  # automatic retry for now.
  sidekiq_options retry:false

  def perform(param)
    puts "Started Sidekiq RotateKeys task."
    # Generate a new primary key and mark old key
    # as primary: false
    DataEncryptingKey.generate_new_primary

    # For each encrypted string not using current 
    # primary key, decrypt the string and encrypt 
    # using new primary key
    EncryptedString.re_encrypt_all(DataEncryptingKey.primary)

    # Delete any unused primary: false keys
    DataEncryptingKey.delete_unused_keys

    puts "Completed RotateKeys job."
  end
end