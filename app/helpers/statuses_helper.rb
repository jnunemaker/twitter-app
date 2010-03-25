module StatusesHelper
  def pretty_datetime(datetime)
    date = datetime.strftime('%b %e, %Y').downcase
    time = datetime.strftime('%l:%M%p').downcase
    content_tag(:span, date, :class => 'date') + " " + content_tag(:span, time, :class => 'time')
  end
end
