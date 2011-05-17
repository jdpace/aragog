require 'spec_helper'

describe Aragog::Handler::Base do

  let(:request) { successful_request }
  let(:subject) { Aragog::Handler::Base.new request}

  context '#new' do
    it 'takes a request' do
      handler = Aragog::Handler::Base.new request
      handler.request.should == request
    end
  end

  context '.handle' do
    it 'handles a given request and reports the outcome' do
      handler = Aragog::Handler::Base.new request
      handler.expects(:handle)
      Aragog::Handler::Base.expects(:new).with(request).returns(handler)
      Aragog.expects(:report).with(handler)

      Aragog::Handler::Base.handle request
    end
  end

  context "#handle" do
    it "must be implemented by the subclass" do
      lambda {
        subject.handle
      }.should raise_exception(NotImplementedError)
    end
  end

  context "#failure_message" do
    it "must be implemented by the subclass" do
      lambda {
        subject.failure_message
      }.should raise_exception(NotImplementedError)
    end
  end

  context "#passed?" do
    it "returns true if the request passed the handler's criteria" do
      subject.passed = true
      subject.should be_passed
      subject.should_not be_failed
    end

    it "returns false if the request did not pass the handler's criteria" do
      subject.passed = false
      subject.should_not be_passed
      subject.should be_failed
    end
  end

end
