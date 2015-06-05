class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_inviter!, only: [:new, :create]
  before_action :require_no_authentication, only: [:update]

  rescue_from ActiveRecord::RecordInvalid do |exception|
    flash[:alert] = exception.message
    respond_with_navigational(resource) { render :new }
  end

  def new
    super
  end

  def create
    self.resource = User.new(invitation_params)
    self.resource.role = Role.find_by(name: 'manager')
    resource.skip_password = true
    if resource.valid?
      resource.skip_invitation = true
      resource.invite!(current_inviter)
      resource.deliver_invitation
      render 'devise/invitations/create'
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  private

  def invitation_params
    resource_params.permit(:email)
  end
end
