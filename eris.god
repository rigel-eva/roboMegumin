God.watch do |w|
	w.name="roboMegumin"
	w.start="ruby #{File.dirname(__FILE__)}/core.rb"
	w.keepalive
	w.log = '/var/log/roboMegumin/adventure.log'
end
