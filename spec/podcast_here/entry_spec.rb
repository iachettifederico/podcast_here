require "spec_helper"

module PodcastHere
  RSpec.describe Entry do
    it "understands mp3 files" do
      entry = Entry.new(name: "audio.mp3")

      expect(entry.mime_type).to eql("audio/mpeg")
    end

    it "understands ogg files" do
      entry = Entry.new(name: "audio.ogg")

      expect(entry.mime_type).to eql("audio/vorbis")
    end

    it "mime type defaults to text/plain" do
      entry = Entry.new(name: "audio.xyz")

      expect(entry.mime_type).to eql("text/plain")
    end

    it "formats the updated field" do
      entry = Entry.new(name: "whatever", updated: Time.new(2017, 6, 12, 1, 2, 3, 0))

      expect(entry.updated).to eql("2017-06-12T01:02:03+00:00")
    end

    it "uses the name as the identity field" do
      entry1 = Entry.new(name: "a")
      entry2 = Entry.new(name: "a")

      expect(entry1 == entry2).to eql(true)
    end
  end
end
