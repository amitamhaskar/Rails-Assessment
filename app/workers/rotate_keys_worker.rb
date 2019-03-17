class RotateKeysWorker
  include Sidekiq::Worker

  def perform(param)
    puts "Performing Sidekiq RotateKeys task for #{param}"
    sleep(300)
    puts "Completed job after sleeping"
  end
end