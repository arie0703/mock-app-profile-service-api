module SessionHelper
  def sign_in(member)
    session_token = SecureRandom.hex(32)
    key = "user:#{@member.id}:session_token"
    $redis.set(key, session_token)
    @current_member = member
  end

  def current_member
    session_token = request.headers['Authorization']
    return false unless session_token

    # Session Tokenからuser_idを取得
    user_id = $redis.keys("user:*:session_token").find do |key|
      $redis.get(key) == session_token
    end&.split(':')&.second

    if user_id.present?
      @current_member ||= Member.find_by(id: user_id)
    end
  end

  def signed_in?
    current_member.present?
  end

  def sign_out
    if current_member.present?
      $redis.del("user:#{current_member.id}:session_token")
    end
  end
end
