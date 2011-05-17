require 'spec_helper'

describe Aragog do

  context '#crawl' do

    it "creates a new caller with the specified path" do
      Aragog::Crawler.expects(:new).with('/path').
        returns(stub('crawler', :crawl => true, :queue => []))
      Aragog.crawl('/path')
    end

    it "allows the user to modify the configuration by passing a block" do
      Aragog.configuration.expects(:dup).returns(Aragog.configuration)
      Aragog.configuration.expects(:timeout=).with(99)
      Aragog.crawl('/path') do |crawler|
        crawler.timeout = 99
      end
    end

    it "sets the config back to the way it was previously" do
      prev_timeout = Aragog.configuration.timeout
      Aragog.crawl('/path') do |crawler|
        crawler.timeout = 99
      end
      Aragog.configuration.timeout.should_not == 99
      Aragog.configuration.timeout.should == prev_timeout
    end

  end

end
