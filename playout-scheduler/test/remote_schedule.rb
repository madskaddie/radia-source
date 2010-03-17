#!/usr/bin/ruby


require 'rubygems'
require 'eventmachine'


dir = File.dirname(File.expand_path(__FILE__))

require File.join(dir, '../config')
require File.join(dir, '../script/playout-server')

EventMachine::run { PlayoutScheduler::run({:scheduler_uri => ""}) }
