module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Cruceros"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_price(int)
    '%.2f' % int
  end
end
