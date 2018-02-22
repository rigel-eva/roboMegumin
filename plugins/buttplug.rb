require "buttplugrb"
if defined? MEGUMIN 
    $bot.message(:start_with=>"#!Vibe") do |event|
        event.respond "N ... no please no ... yamate ..."
        $bot.send_file(event.channel.id,File.new("#{APPDIR}/assets/UOCEbLn.png"))
    end
elsif __FILE__==$0
  client=Buttplug::Client.new("wss://192.168.1.40:6969/buttplug")
  sleep 0.1
  client.startScanning();
  sleep 1
  devices=client.listDevices()
  client.stopScanning()
  controller=Buttplug::Device.new(client,devices[0])
 # if(request.length==2)#Ok, So something has gone wrong if our request length is 2. it should have returned something.
    #client.instance_variable_get(:@eventMachine).join
  #end
  #ok we are gonna make a few assumptions here ... primarily that you are using an xbox controller
  if(controller.methods.include? :vibrateAll)
    (0..20).each{|i|
      controller.vibrateAll(rand(0.0..1.0))
      sleep(rand(0.5..2))
    }
    controller.vibrateAll(0.0)
  end
end