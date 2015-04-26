class UsersController < ApplicationController
  include UndoDelete
  before_action :authenticate_user!
  decorates_assigned :users, with: UsersDecorator

  def index
    @q = User.order(name: :asc).search(params[:q])
    @users = @q.result.page(params[:page])
  end

  def destroy
    if user.destroy
      flash[:notice] = "User was successfully deleted. #{undo_link(user)}"
    else
      flash[:alert] = 'Failed to delete user.'
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
