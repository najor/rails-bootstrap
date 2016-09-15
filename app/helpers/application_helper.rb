# Main Helper for the view
module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    is_same_column = column == sort_column
    css_class = is_same_column ? "current #{sort_direction}" : nil
    direction = is_same_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, { sort: column, direction: direction }, class: css_class
  end
end
