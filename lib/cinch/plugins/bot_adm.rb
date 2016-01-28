#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class BotAdm
      include Cinch::Plugin

      set plugin_name: "BotAdm",
          help: "If you have to ask how to use it, you're probably not allowed"

      timer 300, :method => :fix_nick

      match /faggot( .+)?/, method: :faggot
      match /join\s+(#[#\w\d_.-]+)/, method: :join
      match /part\s+(#[#\w\d_.-]+)/, method: :part
      match /say (\S+) (.*)/, method: :say
      match /op (\S+) (\S+)/, method: :op
      match /deop (\S+) (\S+)/, method: :deop
      match /kick (\S+) (\S+)(.*)?/, method: :kick
      match /conf reload/, method: :conf_reload
      match /nick (\S+)/, method: :nick

      def authorized?(m)
        $conf.admins.each {|admin|
          if admin["nick"] == m.user.nick && admin["host"] == m.user.host
            return true
          end
        }

        m.reply "Unauthorized access. This incident will be reported"
        throw "RoflException"
      end

      def faggot(m, me)
        authorized? m
        m.reply %-jmiaster er sexy \- #{me}-
      end

      def join(m, channel)
        authorized? m
        bot.join channel
      end

      def part(m, channel)
        authorized? m
        bot.part channel
      end

      def say(m, channel, message)
        authorized? m
        Channel("##{channel}").privmsg(message)
      end

      def op(m, channel, user)
        authorized? m
        Channel("##{channel}").op(user)
      end

      def deop(m, channel, user)
        authorized? m
        Channel("##{channel}").deop(user)
      end

      def kick(m, channel, user, reason)
        authorized? m
        reason ||= "Fuck off!"
        Channel("##{channel}").kick(user, reason)
      end

      def conf_reload (m)
        authorized? m
        $conf = Settings.new("config.json")
      end

      def nick(m, nick)
        authorized? m
        bot.nick = nick
        $conf.nick = nick
      end

      def fix_nick
        unless bot.nick == $conf.nick
          bot.nick = $conf.nick
        end
      end
    end
  end
end
