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
      match /kick (\S+) (.*) (\S+)/, method: :kick

      def faggot(m, me)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        m.reply %-jmiaster er sexy \- #{me}-
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
        reason = reason || "Fuck off!"
        Channel("##{channel}").kick(user)
      end

    end
  end
end
