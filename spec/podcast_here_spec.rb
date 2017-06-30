require "spec_helper"

RSpec.describe PodcastHere do
  it "produces an rss feed from one file" do
    files = [
             {
              name: "example",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example</id>
          <link href="example"/>
          <title>example</title>
          <link rel="enclosure" type="text/plain" href="example"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "produces an rss feed from two files" do
    files = [
             {
              name: "example",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             },
             {
              name: "example2",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example</id>
          <link href="example"/>
          <title>example</title>
          <link rel="enclosure" type="text/plain" href="example"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
        <entry>
          <id>example2</id>
          <link href="example2"/>
          <title>example2</title>
          <link rel="enclosure" type="text/plain" href="example2"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "adds the mp3 mimetype" do
    files = [
             {
              name: "example.mp3",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example.mp3</id>
          <link href="example.mp3"/>
          <title>example.mp3</title>
          <link rel="enclosure" type="audio/mpeg" href="example.mp3"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "adds the mp4 mimetype" do
    files = [
             {
              name: "example.ogg",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example.ogg</id>
          <link href="example.ogg"/>
          <title>example.ogg</title>
          <link rel="enclosure" type="audio/vorbis" href="example.ogg"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "adds the updated time" do
    files = [
             {
              name: "example.mp3",
              updated: Time.new(2018, 6, 15, 12, 14, 22, "-02:00"),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example.mp3</id>
          <link href="example.mp3"/>
          <title>example.mp3</title>
          <link rel="enclosure" type="audio/mpeg" href="example.mp3"/>
          <updated>2018-06-15T12:14:22-02:00</updated>
          <dc:date>2018-06-15T12:14:22-02:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "allows an empty enty list" do
    files = []
    feed = PodcastHere::FeedBuilder.new(files, date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "allows to set a title" do
    files = []
    feed = PodcastHere::FeedBuilder.new(files, title: "TITLE", date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>TITLE</id>
        <title>TITLE</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "allows to set an author" do
    files = []
    feed = PodcastHere::FeedBuilder.new(files, author: "AUTHOR", date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>AUTHOR</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "allows to set a base url" do
    files = [
             {
              name: "example",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, base_url: "http://example.com", date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example</id>
          <link href="http://example.com/example"/>
          <title>example</title>
          <link rel="enclosure" type="text/plain" href="http://example.com/example"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

  it "removes spureous slashes" do
    files = [
             {
              name: "example",
              updated: Time.new(2017, 6, 14, 11, 21, 31, 0),
             }
            ]
    feed = PodcastHere::FeedBuilder.new(files, base_url: "http://example.com/", date: Time.new(2017, 6, 12, 1, 2, 3, 0))

    expected = <<~EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <feed xmlns="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <author>
          <name>PodcastHere</name>
        </author>
        <id>PodcastHere Feed</id>
        <title>PodcastHere Feed</title>
        <updated>2017-06-12T01:02:03+00:00</updated>
        <dc:date>2017-06-12T01:02:03+00:00</dc:date>
        <entry>
          <id>example</id>
          <link href="http://example.com/example"/>
          <title>example</title>
          <link rel="enclosure" type="text/plain" href="http://example.com/example"/>
          <updated>2017-06-14T11:21:31+00:00</updated>
          <dc:date>2017-06-14T11:21:31+00:00</dc:date>
        </entry>
      </feed>
    EOF

    expect(feed.rss).to eql(expected)
  end

end
