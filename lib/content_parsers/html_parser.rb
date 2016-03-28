require 'open-uri'
require 'nokogiri'

module ContentParsers
  module HTMLParser
    class << self
      def get_content(url)
        content = Nokogiri::HTML(get_html_content(url))
        content.css('style,script').remove
        content.at('body').inner_text.to_s.strip
      end

      private

      def get_html_content(url)
        open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
      end
    end
  end
end
