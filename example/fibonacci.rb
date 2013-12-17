#!/usr/bin/env ruby

require_relative '../lib/actory'
require_relative './lib/benchmark'

ret, time = Benchmark.measure do
  begin
    runner = Actory::Sender::Runner.new
    args = (1..34).to_a
    res = runner.message("fibonacci", args)
    res.each do |r|
      r.each do |k,v|
        puts "#{k} returned #{v}"
      end
    end
  rescue => e
    @num == nil ? @num = 0 : @num += 1
    puts e
    puts $@
    sleep 1
    retry if @num < 2
  end
end

puts " => #{ret}"
puts " => time = #{time} sec"
