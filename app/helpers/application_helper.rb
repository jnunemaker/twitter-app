# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def pretty_datetime(datetime)
    str = datetime.strftime('%b %d, %Y^%H:%M%p')
    str.gsub!(/\^0/, '^')
    str.tr!('AM', 'am')
    str.tr!('PM', 'pm')
    date, time = str.split('^')
    content_tag(:span, date, :class => 'date') + " " + content_tag(:span, time, :class => 'time')
  end
  
  def linkup_replies(text)    
    text.gsub!(/@([\w]+)(\W)?/, '@<a href="/users/\1">\1</a>\2')
    text
  end
end
