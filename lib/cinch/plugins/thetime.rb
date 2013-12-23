#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class TheTime
      include Cinch::Plugin

      match /thetime/

      def execute(m)
        m.reply "#{m.user.nick}: Looks like it's fuck-this-shit o'clock"
      end
    end
  end
end