require "rmagick"
FONT="#{APPDIR}/assets/here_lies_mecc.ttf"
TOMB_X={
    "name"=>194,
    "epitaph"=>112
}
TOMB_Y={
    "name"=>141,
    "epitaph"=>160
}
TOMB_WIDTH={
    "name"=>132,
    "epitaph"=>188
}
TOMB_HEIGHT={
    "name"=>16,
    "epitaph"=>57
}
EPITAPH_ROWS=4
EPITAPH_COLUMNS=18
def wordwrap(textToWrap,columns)
    workingString=textToWrap
    stringArray=Array.new();
    returnString=""
    while(workingString.length>0)
        stringArray.push(workingString.slice!(0..columns-1))
    end
    (0..stringArray.length-2).each{|i|
        returnString+="#{stringArray[i]}\n"
    }
    returnString+=stringArray[-1]
    return returnString
end
def carveTombstone (name,epitaph)
    tombstone=Magick::ImageList.new("#{APPDIR}/assets/Tombstone.png")
    pen=Magick::Draw.new
    pen.font=FONT
    pen.pointsize = 16
    pen.fill = "#000000"
    #pen.font_weight=Magick::NormalWeight
    pen.gravity=Magick::NorthGravity#For our name
    tombstone=tombstone
    tombstone.annotate(pen,TOMB_WIDTH["name"],TOMB_HEIGHT["name"],TOMB_X["name"],TOMB_Y["name"],name)
    pen.gravity=Magick::WestGravity#Switching gears for our epitaph
    tombstone.annotate(pen,TOMB_WIDTH["epitaph"],TOMB_HEIGHT["epitaph"],TOMB_X["epitaph"],TOMB_Y["epitaph"],wordwrap(epitaph,EPITAPH_COLUMNS))
    tombstone.format="png"
    return tombstone
end
def megumin_carveTombstone(event)
#event.respond "You\'re not dead ... not yet anyway 😝"
    puts event.content
    user=event.author
    epitaph=""
    #Grabbing The Inital ID here
    match=/#!RIP <@!?([0-9]+)>(.*)/m.match(event.content)
    unless(match.nil?)
        userID=match[1]
        epitaph=match[2]
        user=$bot.member(event.server.id,userID)
    else
        match=epitaph=/#!RIP (.+)/m.match(event.content)
        unless match.nil?
            epitaph=match[1]
        else
            epitaph="Booped the wrong\nCat and Dog ..."
        end
    end
    if(user.nil?)
        user=event.author
        epitaph="Tried to bury\na ghooooost"
    end
    puts epitaph
    if(!user.nick.nil?)
        carveTombstone(user.nick,epitaph).write("#{APPDIR}/boop.png")
    elsif
        carveTombstone(user.username,epitaph).write("#{APPDIR}/boop.png")
    end
    $bot.send_file(event.channel.id,File.new("#{APPDIR}/boop.png"))
    File.delete("#{APPDIR}/boop.png")
end
if(!(MEGUMIN.nil?()))
    $bot.message(:start_with=>"#!RIP") do |event|
        megumin_carveTombstone(event)
    end
    $bot.message(:start_with=>"#!rip") do |event|
        megumin_carveTombstone(event)
    end
end