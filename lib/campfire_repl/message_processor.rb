require 'formatador'

module CampfireRepl

  class MessageProcessor

    attr_reader :processors

    def initialize
      @processors = [TextMessage.new, PasteMessage.new, EnterMessage.new, LeaveMessage.new]
      @all_colors = ["red", "green", "yellow", "blue", "magenta", "purple", "cyan", "white", "light_red",
                     "light_green", "light_yellow", "light_blue", "light_magenta", "light_purple", "light_cyan"]
      @available_colors = @all_colors.dup
      @user_colors = {}
    end

    def process_messages messages
      messages.each do |m|
        processors.each do |p|
          if p.applies_to? m
            p.process m, get_color(m.user)
          end
        end
      end
    end

    def get_color user
      color = @user_colors.fetch(user.id, @available_colors.pop)
      @user_colors[user.id] = color
      @available_colors = @all_colors.dup if @available_colors.empty?

      color
    end
  end

  class TextMessage
    def process message, color
      Formatador.display_line("[#{color}]#{message.user.name}[/]: #{message.body}")
    end

    def applies_to? message
      return message.type == "TextMessage"
    end
  end

  class PasteMessage
    def process message, color
      format = Formatador.new
      format.display_line("[#{color}]#{message.user.name}[/]:")
      format.indent do
        format.display_line("#{message.body}")
      end
    end

    def applies_to? message
      return message.type == "PasteMessage"
    end
  end

  class EnterMessage
    def process message, color
      Formatador.display_line("[#{color}]#{message.user.name}[/] has entered the room.")
    end

    def applies_to? message
      return message.type == "EnterMessage"
    end
  end

  class LeaveMessage
    def process message, color
      Formatador.display_line("[#{color}]#{message.user.name}[/] has left the room.")
    end

    def applies_to? message
      return ["LeaveMessage", "KickMessage"].include? message.type
    end
  end
end