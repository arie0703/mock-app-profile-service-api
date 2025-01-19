module SessionHelper
  def sign_in(member)
    session[:member_id] = member.id
  end

  def current_member
    if session[:member_id].present?
      @current_member ||= Member.find_by(id: session[:member_id])
    end
  end

  def signed_in?
    current_member.present?
  end

  def sign_out
    session.delete(:member_id)
    @current_member = nil
  end
end
