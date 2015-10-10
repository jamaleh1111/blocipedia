class UsersController < ApplicationController
  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def update
  end

  def show
    @user = User.find(params[:id])
    @wikis = policy_scope(Wiki).select {|w| w.user_id == @user.id}.paginate(page: params[:page], per_page: 5)
  end

  
end
