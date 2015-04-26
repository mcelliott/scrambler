class TenantsController < ApplicationController
  include UndoDelete
  before_action :authenticate_user!
  before_action :authorize_tenant
  load_and_authorize_resource except: [:index, :new]

  decorates_assigned :tenant
  decorates_assigned :tenants, with: PaginatedCollectionDecorator

  def index
    @q = Tenant.order(created_at: :desc).search(params[:q])
    @tenants = @q.result.page(params[:page])
  end

  def create
    @tenant = Tenant.new(tenant_params)
    flash[:notice] = 'Tenant was successfully created.' if @tenant.save
  end

  def new
    @tenant = Tenant.new
  end

  def edit
  end

  def update
    flash[:notice] = 'Tenant was successfully updated.' if @tenant.update(tenant_params)
  end

  def destroy
    if @tenant.destroy
      flash[:notice] = 'Tenant was successfully deleted. #{undo_link(@tenant)}'
    else
      flash[:alert] = 'Failed to delete tenant.'
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :database, :domain, :enabled)
  end

  def authorize_tenant
    authorize! :manage, @tenant
  end
end
