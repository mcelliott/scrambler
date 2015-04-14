class UsersController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :users, with: UsersDecorator

  def index
    @q = User.order(name: :asc).search(params[:q])
    @users = @q.result.page(params[:page])
  end

  def destroy
    user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
