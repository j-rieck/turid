#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class BotAdm
      include Cinch::Plugin

      match /faggot( .+)?/, method: :faggot

      def faggot(m, me)
        return unless $conf.admins.include?({"nick"=>"#{m.user}", "host"=>"#{m.user.host}"})
        m.reply %-jmiaster er sexy \- #{me}-
      end

    end
  end
end
