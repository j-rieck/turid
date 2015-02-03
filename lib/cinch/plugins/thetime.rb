#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class Thetime
      include Cinch::Plugin

      set plugin_name: "Thetime",
      	help: "Show bot time by using the command .thetime"

      match /thetime/

      def execute(m)
        m.reply "#{m.user.nick}: Looks like it's fuck-this-shit o'clock"
      end
    end
  end
end