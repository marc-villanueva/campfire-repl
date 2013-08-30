require 'spec_helper'

module CampfireRepl

  describe ConfigFile do
    subject { ConfigFile.new Dir.getwd + "/bin/config.json" }

    context '[]' do
      it 'should access value by key' do
        subject["account_info"].should be_a Hash
      end

      it 'should access value by key or symbol' do
        subject[:account_info].should be_a Hash
        subject["account_info"].should be_a Hash
      end
    end

    context'fetch' do
      it 'should return value by key if it exists' do
        subject.fetch(:account_info, "").should be_a Hash
      end

      it 'should return the default value if key does not exist' do
        subject.fetch(:doesnt_exist, []).should be_a Array
      end
    end
  end

end