module UndoDelete
  extend ActiveSupport::Concern

  included do
    def undo_link(resource)
      view_context.link_to("undo", revert_version_path(resource.versions.last), method: :post)
    end
  end
end