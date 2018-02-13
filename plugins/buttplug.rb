require "rest-client"
if(!(MEGUMIN.nil?()))
    $bot.message(:start_with=>"#!Vibe") do |event|
        event.respond "N ... no please no ... yamate ..."
        $bot.send_file(event.channel.id,File.new("#{APPDIR}/assets/UOCEbLn.png"))
    end
end