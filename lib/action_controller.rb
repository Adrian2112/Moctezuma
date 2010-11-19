class ActionController
  
  attr_accessor :params, :html
  
  def initialize(args)
    action = args[:action]
    self.params = args
    self.send(action)    
  end
  
  def render
    view = get_view_file
    return layout { view }
  end
  
  def layout
    if self.html.nil?
      begin
        vista = File.new("./app/views/layout/application_layout.html.erb").read
        self.html = ERB.new(vista).result(binding)
      rescue Errno::ENOENT
        vista = File.new("./404.html").read
        self.html = vista
      end
    end
    return self.html
  end
  
  def get_view_file
    view_html = ""
    begin
      vista = File.new("./app/views/#{self.params[:controller]}/#{self.params[:action]}.html.erb").read
      view_html = ERB.new(vista).result(binding)
    rescue Errno::ENOENT
      vista = File.new("./404.html").read
      view_html = vista
    end
    
    return view_html
  end
  
  def method_missing(sym, *args, &block)
    
  end
  
  def redirect_to(url)
    self.html = "<meta http-equiv='REFRESH' content='0;url=#{url}'>"
  end
  
end