class CollaborationsController < ApplicationController

  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborating_users
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    # Take comma-separated usernames and turn into user_ids
    user_ids = (User.where(username: params[:user][:username].split(",").map(&:strip))).ids
    user_ids << @wiki.user_id
    # not sure how to authorize using Pundit here
    if @wiki.collaborating_user_ids += user_ids
      flash[:notice] = "Collaborators added successfully"
      redirect_to wiki_path(@wiki)
    else
      flash[:alert] = "There was an error adding collaborators to your wiki"
      redirect_to wiki_path(@wiki)
    end
  end

  def destroy
    @collaboration = Collaboration.find(params[:id])
    authorize @collaboration

    if @collaboration.destroy
      flash[:notice] = "Collaboration was successfully removed"
      redirect_to wiki_collaborations_path
    else
      flash[:alert] = "There was an error removing the collaborator. Please try again"
      redirect_to wiki_collaborations_path
    end
  end
end
