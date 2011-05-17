require 'spec_helper'

class FooReporter < Aragog::Reporter::Base

  self.default_options = {:foo => 'bar'}

  def report(handler)
    print ':)'
  end

end

describe Aragog::Reporter::Base do

  context "#report" do
    let(:reporter) { Aragog::Reporter::Base.new }

    it 'throws a NotImplementedError since it needs to be implemented by the subclass' do
      expect do
        reporter.report 'handler'
      end.should raise_error NotImplementedError
    end
  end

  context 'reporter options' do
    let(:reporter) { FooReporter.new :baz => 'zap' }

    it 'has defaults' do
      reporter.options[:foo].should == 'bar'
    end

    it 'holds on to ones that are passed in' do
      reporter.options[:baz].should == 'zap'
    end
  end

end
