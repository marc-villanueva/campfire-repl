module CampfireRepl

  class ConfigFile

    def initialize filepath
      @config = JSON.parse IO.read(filepath)
    end

    def [](key)
      @config.fetch(key.to_s, "")
    end

    def fetch(key, default)
      @config.fetch(key.to_s, default)
    end
  end

end