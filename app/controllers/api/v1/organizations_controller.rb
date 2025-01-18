class Api::V1::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    render json: @organizations, status: :ok
  end

  def show
    @organization = Organization.find(params[:id])
    render json: @organization, status: :ok
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: @organization, status: :ok
    else
      render json: @organization.errors, status: :bad_request
    end
  end
end
