require 'test_helper'

class DataEncryptingKeysControllerTest < ActionController::TestCase

  def setup
    @data_encrypting_key = DataEncryptingKey.generate!(primary: true)
  end

  test "POST #rotate returns error when called twice" do
    post :rotate
    post :rotate

    assert_response :conflict

    json = JSON.parse(response.body)
    assert json["message"].include?("Cannot schedule a new key rotation at")
  end

  test "GET #status returns job enqueued when rotate called once" do
    post :rotate
    get :status

    json = JSON.parse(response.body)
    assert_equal "Key rotation has been queued", json["message"]
  end
end
