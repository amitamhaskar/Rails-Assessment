class DataEncryptingKeysController < ApplicationController

  before_action :load_encrypted_string, only: [:show, :destroy]

  def rotate
    RotateKeysWorker.perform_async('rotate')
  end

  def status
    if RotateKeyJobs.queued_jobs > 0 
      render json: { status: DataEncryptingKey.ROTATE_STATUSes[:QUEUED] }
    elsif RotateKeyJobs.busy_jobs > 0
      render json: { status: DataEncryptingKey.ROTATE_STATUSes[:IN_PROGRESS] }
    else
      render json: { status: DataEncryptingKey.ROTATE_STATUSes[:EMPTY] }
    end
  end
end
