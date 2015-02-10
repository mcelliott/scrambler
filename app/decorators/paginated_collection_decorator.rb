class PaginatedCollectionDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value

  # Form Select options for all organisations in the collection
  def options_for_select(selected = nil)
    h.options_for_select(
        map { |obj| [obj.select_option, obj.id] },
        selected
    )
  end
end
