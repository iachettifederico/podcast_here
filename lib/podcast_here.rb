require "podcast_here/version"
require "builder"

module PodcastHere
  class FeedBuilder
    attr_reader :entries
    attr_reader :builder
    attr_reader :title
    attr_reader :author
    attr_reader :base_url

    def initialize(entries, title: "PodcastHere Feed", author: "PodcastHere", base_url: nil, date: Time.now)
      @entries = entries
      @date = date
      @title = title
      @author = author
      @base_url = base_url

      @builder = Builder::XmlMarkup.new(indent: 2)
    end

    def rss
      builder.instruct!
      builder.feed("xmlns"=>"http://www.w3.org/2005/Atom",
                   "xmlns:dc"=>"http://purl.org/dc/elements/1.1/") do
        builder.author do
          builder.name author
        end
        builder.id title
        builder.title title
        builder.updated "2017-06-12T01:02:03+00:00"
        builder.tag! "dc:date", "2017-06-12T01:02:03+00:00"
        entries.each do |entry|
          name = entry[:name]
          date = entry[:updated].strftime("%Y-%m-%dT%H:%M:%S%:z")
          entry_url = [base_url, name].compact.join(":SLASH:").gsub(/\/?:SLASH:/, "/")

          builder.entry do
            builder.id name
            builder.link(href: entry_url)
            builder.title name
            builder.link(rel: "enclosure", type: mime(name), href: entry_url)

            builder.updated date
            builder.tag! "dc:date", date
          end
        end
      end

      builder.target!
    end

    def mime(name)
      case name
      when /\.mp3/
        "audio/mpeg"
      when /\.ogg/
        "audio/vorbis"
      else
        "text/plain"
      end
    end
  end
end
