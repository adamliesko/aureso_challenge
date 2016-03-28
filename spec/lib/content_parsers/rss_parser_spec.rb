require 'spec_helper'
require 'content_parsers/rss_parser'

describe ContentParsers::RSSParser do
  rss_feed = File.read(File.join(File.dirname(__FILE__), '..', '..', 'dummy', 'rss_aureso_example'))
  before(:each) do
    stub_request(:get, 'http://www.aureso.com/rss')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: rss_feed, headers: {})
  end

  it 'downloads the content from url and returns rss parsed nodes' do
    rss_content = ContentParsers::RSSParser.get_content('http://www.aureso.com/rss')
    expect(rss_content.class).to eq(RSS::Rss)
    expect(rss_content.channel.class).to eq(RSS::Rss::Channel)
    expect(rss_content.items.size).to eq (2)
    expect(rss_content.items.first.description).to eq ('Super cooler decs')
    expect(rss_content.items.last.description).to eq ('Super coolest decs')
  end
end
