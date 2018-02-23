$bot.message(start_with:"#!bash ") do |event|
	if event.author.mention=="<@176537265336614912>"
		#ok ... fisrt step of this terrible idea ...
		command=event.content[7..-1]
		event.respond("um ... ok ... if you're sure ...")
		event.respond("running command: #{command}")
		output=IO.popen(command)
		result=""
		output.readlines.each{|line|
			result+=line+"\n"
		}
		event.respond(result)
		output.close
	else 
		event.respond("pffft, who puts a back door in and lets anyone through?!")
	end
end