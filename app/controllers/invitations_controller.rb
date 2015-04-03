class InvitationsController < Devise::InvitationsController
  def new
    authorize!(User, :invite?)
    super
  end

  def create
    self.resource = User.new(invitation_params)
    authorize!(self.resource, :invite?)
    resource.skip_password = true
    if resource.valid?
      resource.skip_invitation = true
      resource.invite!(current_inviter)
      InvitationMailer.invitation(resource.id).deliver
    else
      render :new
    end
  end

  private

  def invitation_params
    resource_params.permit(:email)
  end
end
