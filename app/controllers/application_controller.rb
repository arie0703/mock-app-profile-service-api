class ApplicationController < ActionController::API
  include SessionHelper
  before_action :signed_in_member
  private

  def signed_in_member
    unless signed_in?
      render json: {message: 'ログインしていません'}, status: :unauthorized
    end
  end
end
