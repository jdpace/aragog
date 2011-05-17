require 'spec_helper'

describe Aragog::Reporter::Progress do

  let(:reporter) { Aragog::Reporter::Progress.new }
  let(:passing_handler) { mock 'Handler', :passed? => true }
  let(:failing_handler) { mock 'Handler', :passed? => false }

  context 'report' do
    it 'prints a dot for passing handlers' do
      reporter.expects(:print).with('.')
      reporter.report passing_handler
    end

    it 'prints an F for failing handlers' do
      reporter.expects(:print).with('F')
      reporter.report failing_handler
    end
  end

end
