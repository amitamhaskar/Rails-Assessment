class DataEncryptingKeysController < ApplicationController

  before_action :load_encrypted_string, only: [:show, :destroy]

  def rotate
    if RotateKeyJobs.add_new?
      RotateKeysWorker.perform_async('rotate')
    else
      render json: { message: RotateKeyJobs.get_status_message },
             status: :conflict
    end
  end

  def status
    render json: { status: RotateKeyJobs.get_status_message }    
  end
end
