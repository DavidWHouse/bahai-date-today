require 'bahai_date'

module TableOfDatesHelper
  def year_row(year)
    rows = []
    rows << content_tag(:td, "1 Baha #{year}")
    rows << content_tag(:td, gregorian_equivalent_naw_ruz(year).html_safe)
    rows << content_tag(:td, twin_holy_days(year).html_safe)
    rows << content_tag(:td, gregorian_equivalent_twin_holy_days(year).html_safe)
    rows << content_tag(:td, ayyam_i_ha_days(year).html_safe)
    rows << content_tag(:td, gregorian_equivalent_ayyam_i_ha(year).html_safe)
    rows.join.html_safe
  end

  def gregorian_equivalent_naw_ruz(year)
    date = BahaiDate::BahaiDate.new(year: year, month: 1, day: 1)
    date.gregorian_date.strftime('%-d %b %Y')
  end

  def twin_holy_days(year)
    month1, day1 = BahaiDate::OccasionFactory.find(:birth_bab, year).split('.')
    date1 = BahaiDate::BahaiDate.new(year: year, month: month1, day: day1)
    month2, day2 = BahaiDate::OccasionFactory.find(:birth_bahaullah, year).split('.')
    date2 = BahaiDate::BahaiDate.new(year: year, month: month2, day: day2)
    if (month1 != month2)
      "#{date1.day.number} #{date1.month.html}, #{date2.day.number} #{date2.month.html}"
    else
      "#{date1.day.number}, #{date2.day.number} #{date2.month.html}"
    end
  end

  def gregorian_equivalent_twin_holy_days(year)
    month1, day1 = BahaiDate::OccasionFactory.find(:birth_bab, year).split('.')
    date1 = BahaiDate::BahaiDate.new(year: year, month: month1, day: day1).gregorian_date
    month2, day2 = BahaiDate::OccasionFactory.find(:birth_bahaullah, year).split('.')
    date2 = BahaiDate::BahaiDate.new(year: year, month: month2, day: day2).gregorian_date
    if (date1.month != date2.month)
      date1.strftime('%-d %b') + ", " + date2.strftime('%-d %b %Y')
    else
      date1.strftime('%-d') + ", " + date2.strftime('%-d %b %Y')
    end
  end

  def ayyam_i_ha_days_for(year)
    BahaiDate::Logic.leap?(year) ? 5 : 4
  end

  def ayyam_i_ha_days(year)
    "1-#{ayyam_i_ha_days_for(year)}"
  end

  def gregorian_equivalent_ayyam_i_ha(year)
    date1 = BahaiDate::BahaiDate.new(year: year, month: -1, day: 1).gregorian_date
    date2 = BahaiDate::BahaiDate.new(year: year, month: -1, day: ayyam_i_ha_days_for(year)).gregorian_date
    if (date1.month != date2.month)
      date1.strftime('%-d %b') + ", " + date2.strftime('%-d %b %Y')
    else
      date1.strftime('%-d') + ", " + date2.strftime('%-d %b %Y')
    end
  end
end
