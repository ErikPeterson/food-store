require 'devise/jwt/test_helpers'

module JWTHelper
  def decode_jwt(response)
    token = response.headers['Authorization'].split(' ')[1]
    Warden::JWTAuth::TokenDecoder.new.call(token)
  end

  def auth_for_user(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end

  def post_with_authorization(user, path, config)
    config[:headers] ||= {}
    config[:headers]['CONTENT_TYPE'] = 'application/json'
    config[:headers].merge!(auth_for_user(user))
    post(path, config)
  end
end
