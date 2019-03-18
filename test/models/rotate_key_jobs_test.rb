require 'test_helper'

class DataEncryptingKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add_new?" do
    if RotateKeyJobs.queued_jobs > 0 or 
      RotateKeyJobs.busy_jobs > 0
      assert_equal false, RotateKeyJobs.add_new?
    else
      assert_equal true, RotateKeyJobs.add_new?
    end
  end

  test "queue full" do
    RotateKeysWorker.perform_async()
    assert_equal false, RotateKeyJobs.add_new?
    assert_not_equal 0, RotateKeyJobs.queued_jobs
  end

  test "get_status_message" do 
    RotateKeysWorker.perform_async()
    assert_equal "Key rotation has been queued", RotateKeyJobs.get_status_message
  end
end
