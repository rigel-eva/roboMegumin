require 'faye/websocket'
require 'eventmachine'
require 'json'
module Buttplug
  class Client
    def initialize(serverLocation)
      @location=serverLocation
      #Ok Explanation time!
      # * @EventQueue - The events we are triggering on the server, Expected to be an array, with the first element being the message Id, and the second being the message itself!
      # * @responseQueue - And our messages back from the server! Will be an array with the 
      @eventQueue=EM::Queue.new
      @eventMachine=Thread.new{EM.run{
        eventQueue=@eventQueue 
        messageWatch={}
        ws = Faye::WebSocket::Client.new(@location)
        ws.on :open do |event|
          p [Time.now, :open]
          ws.send '[{"RequestServerInfo": {"Id": 1, "ClientName": "roboMegumin", "MessageVersion": 1}}]'
        end
        ws.on :message do |event|
          message=JSON::parse(event.data)[0]
          message.each{|key,value|
            #We don't really care about the key just yet ... We are going to just care about finding our ID
            if(messageWatch.keys.include?(value["Id"]))
              messageWatch[value["Id"]]<<{key => value}#And now we care about our key!
              puts messageWatch[value["Id"]].object_id
              messageWatch.delete(value["Id"])
              p [Time.now, :message_recieved, [{key => value}]]
              next
            elsif(key=="ServerInfo")
              p [Time.now, :server_info, value]
            end
          }
        end
        ws.on :close do |event|
          p [Time.now, :close, event.code, event.reason]
          ws = nil
        end
        EM.add_periodic_timer(0.5){
          ws.send "[{\"Ping\": {\"Id\": #{rand(2..4294967295)}}}]"
          eventQueue.pop{|msg|
            ws.send msg[1]
            messageWatch[msg[0]]=msg
            p [Time.now, :message_send, msg[1]] 
          }
        }
      }}
      @eventMachine.run
    end
  end
end

if defined? MEGUMIN 
    $bot.message(:start_with=>"#!Vibe") do |event|
        event.respond "N ... no please no ... yamate ..."
        $bot.send_file(event.channel.id,File.new("#{APPDIR}/assets/UOCEbLn.png"))
    end
elsif __FILE__==$0
  request=[379,'[{"RequestDeviceList": {"Id":379}}]']
  puts "Original Request:#{request}"
  client=Buttplug::Client.new("wss://192.168.1.40:6969/buttplug")
  sleep 0.2
  client.instance_variable_get(:@eventQueue).push(request)
  sleep 2
  puts "Finished Request:#{request}"
end