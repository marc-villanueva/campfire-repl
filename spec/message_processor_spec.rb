require 'spec_helper'

module CampfireRepl

  describe MessageProcessor do
    subject { MessageProcessor.new }

    it 'should allow setting of message processors' do
      subject.processors = [TextMessage.new, PasteMessage.new]
      subject.processors.size.should eql 2
      subject.processors.first.should be_a TextMessage
    end

    it 'should allow setting of output colors' do
      colors = Object.new
      subject.message_colors = colors
      subject.message_colors.should eql colors
    end
  end

end