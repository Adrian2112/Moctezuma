class ActionController
  
  attr_accessor :params
  
  def initialize(args)
    action = args[:action]
    self.params = args
    self.send(action)    
  end
  
  def render
    html = ""
    begin
      vista = File.new("./app/views/#{self.params[:controller]}/#{self.params[:action]}.html.erb").read
      html = ERB.new(vista).result(self.get_binding)
      return html      
    rescue Errno::ENOENT
      vista = File.new("./404.html").read
      html << vista
      return html
    end
  end
  
  def get_binding
    return binding
  end
  
  def method_missing(sym, *args, &block)
    
  end
  
end