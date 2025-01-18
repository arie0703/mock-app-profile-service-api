class Api::V1::MembersController < ApplicationController
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
end
