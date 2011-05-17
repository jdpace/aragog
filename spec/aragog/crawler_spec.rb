require 'spec_helper'

describe Aragog::Crawler do

  context 'being initialized' do
    let(:crawler) { Aragog::Crawler.new '/' }

    it 'builds a queue to work off of' do
      crawler.queue.size.should == 1
      crawler.queue.requests.first.uri.should == '/'
    end

    it 'has not processed any requests' do
      crawler.processed.should be_empty
    end
  end

  context '#crawl' do
    let(:crawler) { Aragog::Crawler.new '/' }
    let(:request_a) { dummy_request '/path_a' }
    let(:request_b) { dummy_request '/path_b' }
    let(:request_c) { dummy_request '/path_c' }
    let(:queue) { Aragog::Queue.new request_a, request_b, request_c }

    it 'performs each request in the queue until it is empty' do
      crawler.queue = queue
      crawler.crawl

      crawler.queue.should be_empty
      crawler.processed.should include(request_a, request_b, request_c)
    end
  end

end

def dummy_request(path)
  request = Aragog::Request.new path
  request.expects(:perform)
  request.expects(:handle)
  request.stubs(:children).returns([])
  request
end
