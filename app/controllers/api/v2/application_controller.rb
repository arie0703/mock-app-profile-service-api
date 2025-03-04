class Api::V2::ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    # クライアントサイドから送信されたCognitoのID Token
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    begin
      decoded_token = decode_jwt_token(token)
      @current_user = decoded_token
    rescue StandardError => e
      Rails.logger.error "JWT verification failed: #{e.message}"
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def decode_jwt_token(token)
    user_pool_id = ENV["COGNITO_USER_POOL_ID"]
    jwks_url = "https://cognito-idp.ap-northeast-1.amazonaws.com/#{user_pool_id}/.well-known/jwks.json"
    jwks = fetch_jwks(jwks_url)
    header = JWT.decode(token, nil, false).last
    jwk_data = jwks['keys'].find { |key| key['kid'] == header['kid'] }
    public_key = JSON::JWK.new(jwk_data).to_key

    JWT.decode(token, public_key, true, { algorithm: 'RS256' }).first
  end

  def fetch_jwks(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
