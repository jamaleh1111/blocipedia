class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def update
  end

  def show
    @user = User.find(params[:id])
    @wikis = policy_scope(Wiki).select {|w| w.user_id == @user.id}
  end

  
end
