class RotateKeysWorker
  include Sidekiq::Worker

  def perform(param)
    puts "Performing Sidekiq RotateKeys task for #{param}"
  end
end