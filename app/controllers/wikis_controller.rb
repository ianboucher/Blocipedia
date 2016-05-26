class WikisController < ApplicationController

  def index
    # @wikis = Wiki.all
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)

    if @wiki.save
      flash[:notice] = "Your Wiki has been created successfully"
      redirect_to @wiki
    else
      flash[:alert] = "Wiki creation was unsuccessful. Please try again."
      redirect_to new_wiki_path
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update(wiki_params)
      flash[:notice] = "Your Wiki was successfully updated"
      redirect_to wiki_path
    else
      flash[:alert] = "There was an error updating you Wiki. Please try again."
      redirect_to edit_wiki_path
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "You Wiki was successfully deleted"
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting this Wiki. Please try again."
      redirect_to wiki_path
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
