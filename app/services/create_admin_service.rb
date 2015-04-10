class CreateAdminService
  def call
    role = Role.find_by(name: 'admin')
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email, role_id: role.id) do |user|
        user.name = 'Matt'
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.confirm!
      end
  end
end
