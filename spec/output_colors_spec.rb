require 'spec_helper'

module CampfireRepl

  describe OutputColors do

    it 'should use a default set of all available colors' do
      default_colors = ["red", "green", "yellow", "blue", "magenta", "purple", "cyan", "white", "light_red",
                        "light_green", "light_yellow", "light_blue", "light_magenta", "light_purple", "light_cyan"]
      colors = MessageColors.new
      colors.all_colors.size.should eql 15
      (colors.all_colors - default_colors).should be_empty
    end

    it 'should allow setting of available colors' do
      default_colors = ["red", "blue"]
      colors = MessageColors.new default_colors
      colors.all_colors.size.should eql 2
      (colors.all_colors - default_colors).should be_empty
    end

    it 'should allow retrieval of colors by key' do
      colors = MessageColors.new
      color = colors["my_key"]
      color.should_not be_nil
    end

    it 'should assign different colors to different keys' do
      output_colors = []
      colors = MessageColors.new
      15.times do |n|
        output_colors << colors[n]
      end

      output_colors.should eql output_colors.uniq
    end

  end

end