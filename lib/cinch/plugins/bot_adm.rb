#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class BotAdm
      include Cinch::Plugin

      match /faggot( .+)?/, method: :faggot
      def faggot(m, me)
        m.reply "thoijasdf"
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        m.reply %-jmiaster er sexy \- #{me}-
      end

      match /join\s+(#[#\w\d_-]+)/, method: :join
      def join(m, channel)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        bot.join channel
      end

      match /part\s+(#[#\w\d_-]+)/, method: :part
      def part(m, channel)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        bot.part channel
      end

    end
  end
end
