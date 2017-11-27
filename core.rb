require "discordrb"
require "json"
KEYS = JSON.parse(File.open("keys.json").read)
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
bot=Discordrb::Bot.new token: KEYS["discordBot"]
bot.message(with_text:'#!explode') do |event|
        event.respond explodeMessages[rand(3)]
        bot.send_file(event.channel.id,File.new("./EXPLOSION!.gif"))
end
bot.run