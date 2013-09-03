module CampfireRepl

  class OutputColors

    def initialize colors=nil
      @all_colors = colors || ["red", "green", "yellow", "blue", "magenta", "purple", "cyan", "white", "light_red",
                               "light_green", "light_yellow", "light_blue", "light_magenta", "light_purple", "light_cyan"]
      @available_colors = @all_colors.dup
      @tracking_hash = {}
    end

    def [](key)
      color = @tracking_hash.fetch(key, @available_colors.pop)
      @tracking_hash[key] = color
      @available_colors = all_colors.dup if @available_colors.empty?

      color
    end

    def all_colors
      @all_colors
    end

  end
end