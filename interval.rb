# frozen_string_literal: true

# Alternatively use #!/usr/bin/env ruby & cmdline.rb
require 'fileutils'
require 'pry'
require 'nokogiri'
require 'open-uri'

# Guess if rails-weekly.ongoodbits.com still being updated?
#
# How many days since the last blog post to rails-weekly and how does that interval compare to other
# blog post intervals?
# # Sample Output:
#     22      2017/11/26 - 2017/11/04
#     22      2021/01/11 - 2020/12/20
#     23      2018/01/08 - 2017/12/16
#     25      2014/07/11 - 2014/06/16
#     26      2019/09/20 - 2019/08/25
#     26      2019/12/27 - 2019/12/01
#     29      2018/03/18 - 2018/02/17
#     29      2019/06/16 - 2019/05/18
#     29      2019/08/18 - 2019/07/20
#     33      2018/11/02 - 2018/09/30
#     34      2019/03/03 - 2019/01/28
#     37      2019/01/22 - 2018/12/16
#     42      2014/10/10 - 2014/08/29
#     57      2020/04/27 - 2020/03/01
#     93      2021/04/27 - 2021/01/24 *
#     159     2020/10/03 - 2020/04/27
class Interval
  def initialize
    doc = Nokogiri::HTML(URI.open('https://rails-weekly.ongoodbits.com/archive'))
    @dates = doc.css('li a').map do |link|
      link.values.first[1..10]
    end
    @dates.unshift(now)
    @intervals = []
  end

  def print
    intervals_gt_days.each do |interval, recent, earlier|
      puts(recent == now ? "#{interval}\t#{recent} - #{earlier} *" : "#{interval}\t#{recent} - #{earlier}")
    end
  end

  private

  def now
    format(DateTime.now)
  end

  def format(datetime)
    datetime.strftime('%Y/%m/%d')
  end

  def diffs
    (0..(@dates.size - 2)).each do |index|
      recent = DateTime.parse(@dates[index])
      earlier = DateTime.parse(@dates[index + 1])
      earlier ||= recent
      @intervals << [(recent - earlier).to_i, format(recent), format(earlier)]
    end
  end

  def intervals_gt_days(number_days = 21)
    diffs
    @intervals.sort { |a, b| a <=> b }.select { |interval, _date, _other_date| interval > number_days }
  end
end
