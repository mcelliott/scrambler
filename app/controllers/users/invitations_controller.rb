class Users::InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_inviter!, only: [:new, :create]
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
      InvitationMailer.invitation(resource.id).deliver
      set_flash_message :notice, :send_instructions, email: resource.email
    else
      render :new
    end
  end

  protected

  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by(invitation_token: params[:invitation_token])
      set_flash_message(:alert, :invitation_token_invalid) if is_flashing_format?
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  private

  def invitation_params
    resource_params.permit(:email)
  end
end
