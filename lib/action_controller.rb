class ActionController
  
  attr_accessor :params, :html
  
  def initialize(args)
    action = args[:action]
    self.params = args
    self.send(action)    
  end
  
  def render
    if self.html.nil?
      begin
        vista = File.new("./app/views/#{self.params[:controller]}/#{self.params[:action]}.html.erb").read
        self.html = ERB.new(vista).result(self.get_binding)
      rescue Errno::ENOENT
        vista = File.new("./404.html").read
        self.html = vista
      end
    end
    
    return self.html
  end
  
  
  def get_binding
    return binding
  end
  
  def method_missing(sym, *args, &block)
    
  end
  
  def redirect_to(url)
    self.html = "<meta http-equiv='REFRESH' content='0;url=#{url}'>"
  end
  
end