module PodcastHere
  class Entry
    attr_reader :name, :updated

    def initialize(name:, updated: Time.now)
      @name    = name
      @updated = updated
    end

    def updated
      @updated.strftime("%Y-%m-%dT%H:%M:%S%:z")
    end

    def mime_type
      case name
      when /\.mp3/
        "audio/mpeg"
      when /\.ogg/
        "audio/vorbis"
      else
        "text/plain"
      end
    end


    def ==(other)
      !! (name == other.name)
    end
  end
end
