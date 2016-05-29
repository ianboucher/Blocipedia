class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  def self.update_collaborations(collaborators, wiki)
    # I know - it's ugly!!
    user_ids = (User.where(username: collaborators.split(",").map(&:strip)).ids << wiki.user_id).uniq!

    # find existing collaborations to be removed and delete them.
    to_remove = wiki.collaborations.map(&:user_id) - user_ids
    to_remove.map { |id| wiki.collaborations.find_by(user_id: id).delete } if to_remove.any?

    # add add new collaborations
    user_ids.map do |id|
      Collaboration.find_or_create_by(user_id: id, wiki_id: wiki.id)
    end
  end
end
