#!/usr/bin/env ruby

require 'parallel'
require 'progressbar'

METHOD = "fibonacci"
ARGS   = (1..34).to_a

require_relative '../lib/actory'
require_relative './lib/benchmark'

res = []
processor_count = Parallel.processor_count
pbar = ProgressBar.new(METHOD, processor_count)

ret, time = Benchmark.measure do
  begin
    plugin = Actory::Receiver::Plugin.new
    res << Parallel.map(ARGS, :in_processes => processor_count) do |arg|
      begin
        pbar.set pbar.current + 1 if pbar.current <= processor_count
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
