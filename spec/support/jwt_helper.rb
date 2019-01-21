module JWTHelper
  def decode_jwt(response)
    token = response.headers['Authorization'].split(' ')[1]
    Warden::JWTAuth::TokenDecoder.new.call(token)
  end
end
