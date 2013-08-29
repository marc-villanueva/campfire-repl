module CampfireRepl

  class ConfigFile

    def initialize filepath
      @config = JSON.parse IO.read(filepath)
    end

    def [](key)
      @config.fetch(key, "")
    end

    def values
      @config.values
    end
  end

end