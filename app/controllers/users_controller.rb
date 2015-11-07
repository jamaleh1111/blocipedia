class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else 
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end 
  end 

  def show
    @user = User.find(params[:id])
    @wikis = policy_scope(Wiki).select {|w| w.user_id == @user.id}.paginate(page: params[:page], per_page: 5)
  end

private

  def user_params
    params.require(:user).permit(:name, :email)
  end 
  
end
