class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 15)
    # @wikis = Wiki.paginate(page: params[:page], per_page: 15)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user_id = current_user.id
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki.  Please try again."
      render :new
    end 
  end 

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    ids = params['col-ids'].split(",") 
    ids.each do |id|
      Collaborator.create(user_id: id, wiki_id:(params[:id]))
    end 

    authorize @wiki
    
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki.  Please try again."
      render :edit
    end 
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted succesfully."
      redirect_to wikis_path
    else 
      flash[:error] = "There was an error deleting wiki."
      render :show
    end 
  end 

  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end 

end 


