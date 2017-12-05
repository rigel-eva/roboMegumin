require 'usagewatch'
usw = Usagewatch
serverName="#{`uname -n`.chop}"
$bot.message(with_text:"#!usage") do |event|
	log("#!usage", event)
	event.respond("Sure ... I guess ... let me pull up my information ...")
	event.respond("Server: #{serverName}")
	event.respond("Current Usage: #{usw.uw_load}")
end
$bot.message(with_text:"#!diskSpace") do |event|
	log("#!diskSpace",event)
	event.respond("I'm not getting fat I swear!")
	event.respond("Disk Space Used: #{usw.uw_diskused}GB")
end