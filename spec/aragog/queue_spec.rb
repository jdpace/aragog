require 'spec_helper'

describe Aragog::Queue do

  let(:queue) { Aragog::Queue.new }
  let(:get_request)     { Aragog::Request.new '/path', :method => :get }
  let(:post_request)    { Aragog::Request.new '/path', :method => :post }
  let(:put_request)     { Aragog::Request.new '/path', :method => :put }
  let(:delete_request)  { Aragog::Request.new '/path', :method => :delete }

  context "#push" do
    it 'adds the request to the queue' do
      queue.should_not include(get_request)
      queue.push get_request
      queue.should include(get_request)
    end
  end

  context "#pop" do
    it 'removes the first item off the queue' do
      queue.push get_request
      queue.push post_request
      first_request = queue.requests.first

      popped_request = queue.pop
      popped_request.should == first_request
      queue.should_not include(first_request)
    end
  end

  it "maintains order based on the requests method" do
    queue.push get_request
    queue.push delete_request
    queue.push post_request
    queue.push put_request

    queue.pop.should == get_request
    queue.pop.should == post_request
    queue.pop.should == put_request
    queue.pop.should == delete_request
  end

end
