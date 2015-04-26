class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user)
    if params[:q].present?  
      query = params[:q]
      @wikis = @wikis.where('title LIKE ?', "%#{query}%")     
    end
    @wikis = @wikis.paginate(page: params[:page], per_page: 10)
  end

  def new
    @wiki = Wiki.new
    authorize @wiki   
  end

  def mine
    @user = current_user
    @wikis = current_user.wikis.paginate(page: params[:page], per_page: 10)
    authorize @wikis
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaborators = User.joins(:collaboratings).where("collaboratings.wiki_id = ?", @wiki.id)
  end
  
  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @collaborators = User.joins(:collaboratings).where("collaboratings.wiki_id = ?", @wiki.id)
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error. Please try again."
      render :show
    end
  end
  
  private 

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
