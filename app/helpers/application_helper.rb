module ApplicationHelper
  def compose_title(title)
    return "Baha'i Date Today" unless title.present?
    "#{title} — Baha'i Date Today"
  end
end
