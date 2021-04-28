# frozen_string_literal: true

# create your sample spec in the root/spec dir
require 'spec_helper'
require_relative '../interval'

describe 'interval' do
  context "I don't know what to put here" do
    it 'returns expected interval sequence' do
      Interval.new.print
      # intervals = interval.diffs
      # intervals = intervals.sort { |a, b| a <=> b }.select { |i, _d_, _dd_| i > 21 }

      # interval.something
      # intervals = interval.intervals_gt_days
      # intervals.each do |i, d2, d1|
      #   puts(d2 == interval.now ? "#{i}\t#{d2} - #{d1} *" : "#{i}\t#{d2} - #{d1}")
      # end
    end
  end
end
