module ApplicationHelper
  def compose_title(title)
    return "Baha'i Date Today" unless title.present?
    "#{title} — Baha'i Date Today"
  end

  def date_as_params(date)
    { year: date.year.bahai_era,
      month: date.month.number,
      day: date.day.number }
  end
end
