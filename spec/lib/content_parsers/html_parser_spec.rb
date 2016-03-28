require 'spec_helper'
require 'content_parsers/html_parser'

describe ContentParsers::HTMLParser do
  before(:each) do
    stub_request(:get, 'http://reuters.com/')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: '<html><body>This is reuters aa inner text content status with status</body></html>', headers: {})
    stub_request(:get, 'http://reuters.com/empty')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: '<html><body>   </body></html>', headers: {})
  end

  it 'downloads the content from url and returns inner text of html page' do
    expect(ContentParsers::HTMLParser.get_content('http://reuters.com')).to eq 'This is reuters aa inner text content status with status'
    expect(ContentParsers::HTMLParser.get_content('http://reuters.com/empty')).to eq ''
  end
end
