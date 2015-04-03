class InvitationMailer < ApplicationMailer
  include ApplicationHelper

  def invitation(user_id)
    load_data(user_id)
    add_logo

    mail(
      subject: 'Invitation instructions',
      to:      @user.email,
      from:    'notifications@tunnelscrambler.com',
      date:    Time.zone.now
    )
  end

  private

  def add_logo
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/scrambler-logo-lrg.png'))
  end

  def load_data(user_id)
    domain = Tenant.current_domain
    @user = User.find(user_id)
    @url = root_url(subdomain: domain)
    @accept_invitation_url ||= accept_user_invitation_url(@user, subdomain: domain, invitation_token: @user.invitation_token)
  end
end
