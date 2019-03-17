class RotateKeyJobs
  # Return the number of jobs that are enqueued
  # in the default sidekiq queue
  def self.queued_jobs
    Sidekiq::Queue.new.size
  end

  # Return the number of busy jobs in sidekiq
  def self.busy_jobs
    ps = Sidekiq::ProcessSet.new
    ps.each do |process|
      return process['busy']   
    end
  end
end
