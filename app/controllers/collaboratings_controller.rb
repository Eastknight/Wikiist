class CollaboratingsController < ApplicationController
  def create
    @collaborating = Collaborating.new
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @user = User.find_by_email(params[:email])
    if !@user
      redirect_to edit_wiki_path(@wiki), alert: "There's no Wikiist user with this email." and return
    end
    if Collaborating.where(wiki_id: @wiki.id, user_id: @user.id).any?
      redirect_to edit_wiki_path(@wiki), alert: "This user is already in your collaborator list!" and return
    end
    @collaborating.wiki_id = @wiki.id
    @collaborating.user_id = @user.id
    if @collaborating.save
      redirect_to edit_wiki_path(@wiki), notice: "Collaborator added!"
    else
      redirect_to edit_wiki_path(@wiki), alert: "Somethin went wrong, please try again!"
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @user = User.friendly.find(params[:user_id])
    @collaborating = Collaborating.where(wiki_id: @wiki.id, user_id: @user.id)
    if @collaborating.destroy_all
      redirect_to edit_wiki_path(@wiki), notice: "Collaborator deleted!"
    else
      redirect_to edit_wiki_path(@wiki), alert: "Somethin went wrong, please try again!"
    end
  end
end
