require 'rss'

module ContentParsers
  module RSSParser
    def self.get_content(url)
      RSS::Parser.parse(url, false)
    end
  end
end
