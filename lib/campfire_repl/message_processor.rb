require 'formatador'

module CampfireRepl

  class MessageProcessor

    def message_colors= value
      @message_colors = value
    end

    def message_colors
      @message_colors ||= OutputColors.new
    end

    def processors= value
      @processors = value
    end

    def processors
      @processors ||= [TextMessage.new, PasteMessage.new, EnterMessage.new, LeaveMessage.new]
    end

    def process_messages messages
      messages.each do |m|
        processors.each do |p|
          if p.applies_to? m
            p.process m, message_colors[m.user.id]
          end
        end
      end
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