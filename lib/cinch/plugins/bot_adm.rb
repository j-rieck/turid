#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class BotAdm
      include Cinch::Plugin

      match /faggot( .+)?/, method: :faggot
      match /say (\S+) (.*)/, method: :say
      match /op (\S+) (\S+)/, method: :op
      match /deop (\S+) (\S+)/, method: :deop
      match /kick (\S+) (\S+)(.*)?/, method: :kick
      match /conf reload/, method: :conf_reload
      match /nick (\S+)/, method: :nick

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

      def say(m, channel, message)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        Channel("##{channel}").privmsg(message)
      end

      def op(m, channel, user)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        Channel("##{channel}").op(user)
      end

      def deop(m, channel, user)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        Channel("##{channel}").deop(user)
      end

      def kick(m, channel, user, reason)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        reason ||= "Fuck off!"
        Channel("##{channel}").kick(user, reason)
      end

      def conf_reload (m)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        $conf = Settings.new("config.json")
      end

      def nick(m, nick)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        bot.set_nick nick
      end

    end
  end
end
