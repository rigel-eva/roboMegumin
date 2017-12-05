require "discordrb"
require "json"
appDir=File.dirname(__FILE__)
KEYS = JSON.parse(File.open("#{appDir}/keys.json").read)
rando=Random.new()

explodeMessages=['Darkness blacker than black and darker than dark,
I beseech thee, combine with my deep crimson.
The time of awakening cometh.
Justice, fallen upon the infallible boundary,
appear now as an intangible distortions!
I desire for my torrent of power a destructive force:
a destructive force without equal!
Return all creation to cinders,
and come frome the abyss!
Explosion! ',
'Oh, blackness shrouded in light,
Frenzied blaze clad in night,
In the name of the crimson demons,
let the collapse of thine origin manifest.
Summon before me the root of thy power hidden within the lands
of the kingdom of demise!
Explosion!',
'Crimson-black blaze, king of myriad worlds,
though I promulgate the laws of nature,
I am the alias of destruction incarnate
in accordance with the principles of all creation.
Let the hammer of eternity descend unto me!
Explosion! ']
def log(command, event)#should probably convert this into a logger thing ... eh /shrug
	puts "#{Time.now}:>#{command} triggered by #{event.author.distinct} in \##{event.channel.name} in #{
	if(!event.server.nil?)
		"server #{event.server.name}"
	else
		"a private message"
	end
	
	}\n\t#{event.author.mention}\n"
end
$bot=Discordrb::Bot.new token: KEYS["discordBot"]
$bot.message(with_text:'#!explode') do |event|
	log("#!explode",event)
    event.respond explodeMessages[rand(3)]
    $bot.send_file(event.channel.id,File.new("#{appDir}/EXPLOSION!.gif"))
end
$bot.message(with_text:'#!restart') do |event|
	log("#!restart",event)
	if event.author.mention=="<@176537265336614912>"
		event.respond "Yawn ... kinda getting sleepy ... See you soon Nora!"
		IO.popen("kill #{Process.pid}")
	elsif event.author.mention=="<@100102820589490176>"
		event.respond "um ... don't you have your own bot that you can restart at will?"
	else
		event.respond "Yeah ... nah you arn't Nora!"
	end
end
Dir["#{appDir}/plugins/*.rb"].each {|file| load file }#Fun new code to load all the ruby code in that one directory!
$bot.run