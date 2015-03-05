class Admin::TenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant, only: [:edit, :show, :update, :destroy]

  decorates_assigned :tenant
  decorates_assigned :tenants, with: PaginatedCollectionDecorator

  def index
    @tenants = Tenant.all.page(params[:page])
  end

  def new
    @tenant = Tenant.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_tenant
    @tenant = Tenant.find params[:id]
  end
end
