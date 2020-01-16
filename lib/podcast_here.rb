require "podcast_here/version"
require "podcast_here/entry"

require "builder"

module PodcastHere
  class FeedBuilder
    attr_reader :entries
    attr_reader :builder
    attr_reader :title
    attr_reader :author
    attr_reader :date
    attr_reader :base_url

    def initialize(entries,
                   title: "PodcastHere Feed",
                   author: "PodcastHere",
                   base_url: nil,
                   date: Time.now)

      @entries  = entries.map {|attrs| Entry.new(**attrs)}
      @date     = date.strftime("%Y-%m-%dT%H:%M:%S%:z")
      @title    = title
      @author   = author
      @base_url = base_url

      @builder  = Builder::XmlMarkup.new(indent: 2)
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

        builder.updated date
        builder.tag! "dc:date", date
        entries.each do |entry|
          name = entry.name
          entry_url = [base_url, name].compact.join(":SLASH:").gsub(/\/?:SLASH:/, "/")

          builder.entry do
            builder.id name
            builder.link(href: entry_url)
            builder.title name
            builder.link(rel: "enclosure", type: entry.mime_type, href: entry_url)

            builder.updated entry.updated
            builder.tag! "dc:date", entry.updated
          end
        end
      end

      builder.target!
    end

    def [](entry_name)
      entries.find { |entry| entry.name == entry_name }
    end

  end
end
