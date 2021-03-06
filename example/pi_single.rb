#!/usr/bin/env ruby

require 'parallel'
require 'progressbar'

METHOD = "pi"
ARGS   = (1..1000).to_a

require_relative '../lib/actory'
require_relative './lib/benchmark'

res = []
processor_count = Parallel.processor_count
pbar = ProgressBar.new(METHOD, ARGS.count)

ret, time = Benchmark.measure do
  begin
    plugin = Actory::Receiver::Plugin.new
    res << ARGS.map do |arg|
      begin
        pbar.set pbar.current + 1 if pbar.current <= ARGS.count
      rescue
      end
      plugin.send(METHOD, arg)
    end
    res.each do |v|
      puts "returned #{v}"
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
