class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "There was an error saving the wiki.  Please try again."
      render :new
    end 
  end 

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
      flash[:notice] = "Wiki was updated."
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "There was an error saving the wiki.  Please try again."
      render :edit
    end 
  end

  def destroy
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted succesfully."
      redirect_to [current_user, @wiki]
    else 
      flash[:error] = "There was an error deleting wiki."
      render :show
    end 
  end 

end 


