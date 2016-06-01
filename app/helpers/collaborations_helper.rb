module CollaborationsHelper

  def list_collaborators(collaborators, wiki)

    if wiki.private?
      if wiki.collaborating_users.any?
        "Collaborators: " + collaborators.map(&:username).join(', ')
      elsif wiki.id == current_user.id
        "No one is collaborating on this wiki. Add some collaborators below:"
      else
        "No one is collaborating on this wiki."
      end
    end

  end  
end
