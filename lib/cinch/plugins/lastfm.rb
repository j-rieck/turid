#!/bin/env ruby
# encoding: utf-8

require 'cinch'
require 'net/http'
require 'rubygems'
require 'json'



module Cinch
  module Plugins
    class Lastfm
      include Cinch::Plugin

      set plugin_name: "Lastfm",
          help: %-Last.fm plugin. Show what you are currently playing. Store your username ".lastfm setuser <username>". Show what your playing with the command .np or see what others are playing with ".np <username>"-

      @@settings_file = Dir.pwd + '/lib/data/lastfm.settings.rb'
      @@host          = 'ws.audioscrobbler.com'
      @@port          = '80'

      def initialize(*args)
        super

        bot.configure do |c|
          c.plugins.options[Cinch::Plugins::Lastfm] = eval( File.open(@@settings_file, "rb").read )
        end
      end

      def handle_recent_tracks (username)
        post_ws          = "/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{config[:api_key]}&format=json"
        request          = JSON.parse( post(post_ws).body )

        if (request['recenttracks'].nil?)
          return "No Lastfm records found on #{username}"
        end

        song             = request['recenttracks']['track'][0]['name']
        artist           = request['recenttracks']['track'][0]['artist']['#text']

        album            = request['recenttracks']['track'][0]['album'].nil? ? '' : " - Album: " + request['recenttracks']['track'][0]['album']['#text']
        last_played_time = request['recenttracks']['track'][0]['date'].nil? ? '' : " - Last played: " + request['recenttracks']['track'][0]['date']['#text']

        return "#{artist} - #{song}#{album}#{last_played_time}"
      end

      def post (post_ws)
        req      = Net::HTTP::Post.new(post_ws, initheader = {'Content-Type' => 'application/json'})
        response = Net::HTTP.new(@@host, @@port).start {|http| http.request(req)}
      end

      match /np\s?(.+)?/
      def execute(m, user)
        if (config[:api_key].nil?)
          debug "No API key specified for plugin. Check conf_last.fm in data folder."
          return
        end

        db = shared[:db]
        user ||= db.get(m.user.nick)
        user ||= m.user.name
        m.reply handle_recent_tracks (user)
      end

      match /lastfm setuser (\S+)/, method: :setuser
      def setuser(m, username)
        db = shared[:db]
        db.put(m.user.nick, username)
        m.reply "Set lastfm username: #{username} for nick #{m.user.nick}"
      end
    end
  end
end
