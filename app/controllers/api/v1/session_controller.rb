class Api::V1::SessionController < ApplicationController
  skip_before_action :signed_in_member

  def create
    @member = Member.find_by(email: member_params[:email])
    if @member && @member.authenticate(member_params[:password])
      sign_in @member
      render json: current_member, status: :ok
    else
      message = @member ? "ログインパスワードが間違っています" : "存在しないアカウントです"
      render json: {message: message, }, status: :bad_request
    end
  end

  def destroy
    sign_out if signed_in?
    render json: {message: 'ログアウトしました'}, status: :ok
  end

  private

  def member_params
    params.fetch(:member, {}).permit(:email, :password)
  end
end
