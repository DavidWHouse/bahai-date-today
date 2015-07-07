module ApplicationHelper
  def compose_title(title)
    return 'Bahá’í Date Today' unless title.present?
    "#{title} — Bahá’í Date Today"
  end
end
