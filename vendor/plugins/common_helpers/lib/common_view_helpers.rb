module CommonViewHelpers
  def hidden_return_to_current(sep='?')
    content_tag(:div, hidden_field_tag('return_to', request.request_uri))
  end
  
  def hidden_return_to_referer(sep='?')
    r = request.env['HTTP_REFERER']
    content_tag(:div, hidden_field_tag('return_to', r)) unless r.blank?
  end
  
  # great for appending return_to parameter to form_for and link_to
  # usage:
  #   link_to h(task.name), task_path(task) + return_to # => /tasks/1?return_to=/the/current/uri
  def return_to(sep="?")
    sep = sep == "&" ? "&amp;" : sep
    "#{sep}return_to=#{CGI::escape(request.request_uri)}"
  end
  
  def url_for_return_to(args)
    params[:return_to].blank? ? url_for(args) : params[:return_to]
  end
  
  def label_tag(element_id, text, options={})
    options.reverse_merge!({:for => element_id})
    content_tag 'label', text, options
  end
  
  # Can be used with a string:
  #   <%- title 'Contacts' -%> # => sets title to Contacts, heading to Contacts
  #   <%- title "#{h(@contact.name)} // Contacts" -%> # => sets title to Contact Name // Contacts, heading to Contacts
  #
  # or with a string and a block:
  #   <%- title 'Contacts' do -%>
  #     <%= link_to 'Some Thing', some_path %>
  #   <%- end -%>
  def title(page_title, &block)
    content_for(:title) { page_title }
    content_for(:heading) { block_given? ? capture(&block) : page_title.split(' // ').last }
  end
  
  def current_controller?(controller_name_or_array)
    if controller_name_or_array.is_a?(Array)
      return true if controller_name_or_array.include?(controller.controller_name)
    else
      return true if request.request_uri.starts_with?("/#{controller_name_or_array}") || controller.controller_name == controller_name_or_array
    end
  end
  
  def current_action?(action_name_or_array)
    is_array = action_name_or_array.is_a?(Array)
    
    if ((is_array && action_name_or_array.include?(controller.action_name)) || 
        (!is_array && controller.action_name == action_name_or_array))
      true
    else
      false
    end
  end
  
  def active_section?(controller_name_or_array, action_name_or_array=nil)
    controller_name_or_array = controller_name_or_array.to_s
    action_name_or_array = action_name_or_array.to_s if action_name_or_array
    if action_name_or_array
      controller.controller_name == controller_name_or_array && current_action?(action_name_or_array) ? true : false
    else
      current_controller?(controller_name_or_array) ? true : false
    end
  end
  
  def active_class(controller_name_or_array, action_name_or_array=nil)
    active_section?(controller_name_or_array, action_name_or_array) ? 'active' : ''
  end
  
  # for use on forms and such, creates a cancel link which will append query string
  # variables and link to index
  def link_to_cancel(*reject)
    if params[:q].blank?
      link_to 'cancel', url_for(:action => 'index') + get_all_gets(:reject => reject)
    else
      link_to 'cancel', url_for(:action => 'search') + get_all_gets(:reject => reject)
    end
  end  
  
  def link_to_view_all(options={})
    options.reverse_merge!(:reject => [], :class => '')
    css_class = options.delete(:class)
    reject    = options.delete(:reject)
    
    if params[:q].blank?
      link_to 'View All', 
              url_for(:action => 'index') + get_all_gets(:reject => reject), 
              :class => css_class
    else
      link_to 'Return To Search Results', 
              url_for(:action => 'search') + get_all_gets(:reject => reject), 
              :class => css_class
    end
  end
  
  # displays flash messages by type of message
  def display_flash_message
    flash_types, string = [ :error, :warning, :notice ], ''
    flash_types.each { |ft| string << "<div class=\"flash #{ft.to_s}\">#{flash[ft]}</div>" unless flash[ft].nil? }
    string
  end
end