module CommonControllerHelpers
  def self.included(base)
    # also make this helper available to views
    base.helper_method :get_all_gets
  end
  
  private
    def return_to_or(default_url)
      next_url = params[:return_to].blank? ? default_url : params[:return_to]
      redirect_to next_url
    end
    
    def get_all_gets(options={})
      options.reverse_merge!({ :pass => {}, :reject => [], :start_with => '?', :separator => '&amp;' })
    
      options[:reject] = options[:reject] << :controller << :action << :commit << :id
    
      # add controller, action and commit to rejects, then flatten, uniq and to_s it
      options[:reject].flatten.uniq
      options[:reject].map!(&:to_s)
    
      #raise options[:reject].inspect
    
      # remove all params that are to be rejected
      # the rejecting of params with key name including / is because of some change in edge rails
      # that i have not investigated, but it works this way so i'm good for now
      pass = params.delete_if { |k,v| options[:reject].include?(k.to_s) || k.to_s.include?('/') }.merge(options[:pass])
    
      # convert non rejected parameters to a query string
      qs = pass.inject(options[:start_with]) { |str,h| str += "#{h[0]}=#{h[1]}#{options[:separator]}"; str }
      qs = qs.gsub(/^\?$/, '')
      # remove trailing ampersand for cleaner url if there
      qs = qs.gsub(/\&amp\;$/, '')
      qs
    end
end