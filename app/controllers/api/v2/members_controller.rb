class Api::V2::MembersController < Api::V2::ApplicationController
  def index
    @members = Member.all
    render json: @members, status: :ok
  end

  def show
    @member = Member.find(params[:id])
    render json: @member, status: :ok
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      render json: @member, status: :ok
    else
      render json: @member.errors, status: :bad_request
    end
  end

  def member_params
    params.fetch(:member, {}).permit(:name, :email, :password, :image_url, :organization_id)
  end
end
