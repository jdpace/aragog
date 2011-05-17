require 'spec_helper'

describe Aragog::Request do

  context 'initialize' do
    it 'takes a uri' do
      request = Aragog::Request.new('/path')
      request.uri.should == '/path'
    end

    it 'defaults to the :get method' do
      request = Aragog::Request.new('/')
      request.method.should == :get
    end

    it 'defaults the params to an empby hash' do
      request = Aragog::Request.new('/')
      request.params.should == {}
    end

    it 'takes an optional method' do
      request = Aragog::Request.new('/', :method => :post)
      request.method.should == :post
    end

    it 'takes an optional params hash' do
      request = Aragog::Request.new('/', :params => {:foo => :bar})
      request.params.should == {:foo => :bar}
    end
  end

  context 'perform' do
    before do
      @response = Rack::MockRequest.new(Aragog.configuration.app).request
      Aragog.driver.stubs(:response).returns(@response)
    end

    it 'makes the driver process the request' do
      request = Aragog::Request.new('/')
      Aragog.driver.expects(:process).
        with(request.method, request.uri, request.params)
      request.perform
    end

    it 'should record the response' do
      request = Aragog::Request.new('/')
      request.perform
      request.response.should == @response
    end
  end

  context 'performed?' do
    it 'returns false if it has not ran yet' do
      request = Aragog::Request.new('/')
      request.should_not be_performed
    end

    it 'returns true if there is a response' do
      request = Aragog::Request.new('/')
      request.perform
      request.should be_performed
    end
  end

end
