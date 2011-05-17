require 'spec_helper'

describe Aragog::Driver::Helpers do

  context "#driver" do
    it 'throws an error if no app is configured' do
      no_app_config = Aragog::Configuration.new
      no_app_config.app = nil

      Aragog.with_config no_app_config do
        expect do
          Aragog.driver
        end.should raise_error Aragog::Driver::NoAppError
      end
    end

    it 'initilzes a new driver' do
      Aragog.driver.should be_instance_of(Aragog.configuration.driver)
    end
  end

end
