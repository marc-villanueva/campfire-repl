require "tinder"
require "formatador"

module CampfireRepl

  class DSL

    attr_accessor :client, :current_room, :messages

    def initialize options={}
      self.messages = MessageProcessor.new

      if options.has_key? :config
        config = ConfigFile.new options[:config]
        login *config.values
      end
    end

    def login *args
      if args.length == 2
        self.client = Tinder::Campfire.new args[0], :token => args[1]
      else
        self.client = Tinder::Campfire.new args[0], :username => args[1], :password => args[2]
      end

      output "Login successful."
    end

    def show_rooms
      client.rooms.each do |room|
        output "[green]#{room.id}[/]\t#{room.name}"
      end
    end

    def join_room room_id
      if room_id =~ /^\d+$/
        join_room_by_id room_id
      else
        join_room_by_name room_id
      end

      output "Successfully joined room #{current_room.name}."
    end

    def listen
      current_room.listen do |m|
        messages.process_messages [m]
      end
    end

    def stop_listening
      current_room.stop_listening
    end

    def show_recent_messages limit=10
      messages.process_messages current_room.recent(limit)
    end

    def leave_room
      current_room.leave
      self.current_room = nil
    end

    def show_users
      output "Current users in room #{current_room.name}"

      current_room.users.each do |user|
          output "[green]#{user.id}[/]\t#{user.name}"
      end
    end

    def speak message
      current_room.speak message
    end

    def quit
      Kernel.exit 0
    end

  private

    def output message
      Formatador.display_line message
    end

    def join_room_by_id room_id
      room = client.find_room_by_id room_id
      room.join
      self.current_room = room
    end

    def join_room_by_name room_name
      room = client.find_room_by_name room_name
      room.join
      self.current_room = room
    end
  end

end