module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def sum_quanlity
    Cart.find_by(id: session[:cart_id]).line_items.sum(:quantity) if session[:cart_id].present?
  end
end
