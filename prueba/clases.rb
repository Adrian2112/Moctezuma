require 'prueba'

names = ['instance1', 'instance2'] # Array of instance vars

Prueba.class_eval do
  attr_accessor *names  
end

x = Prueba.new

puts x.instance