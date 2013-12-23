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

      @@host      = 'ws.audioscrobbler.com'
      @@port      = '80'
      @@conf_file = Dir.pwd + '/lib/data/conf_lastfm.json'
      
      @@conf      = nil
      
      @@api_key   = nil

      def initialize(*args)
        super

        if (File.exist?(@@conf_file))

          begin
            File.open(@@conf_file, "r") do |f|
              @@conf = JSON.load(f)
              @@api_key = @@conf['api_key']
            end
          rescue
            debug "\n\nUnable to read file\n\n"
          end

        else
          debug "\n\nconf_lastfm.json is missing\n\n"
        end
      end

      def handle_recent_tracks (username)
        post_ws          = "/2.0/?method=user.getrecenttracks&user=#{username}&api_key=#{@@api_key}&format=json"
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
      def execute(m)
        if (@@api_key.nil?)
          puts "No API key specified for plugin. Check conf_last.fm in data folder."
          return
        end
        m.reply handle_recent_tracks (m.user.name)
      end
    end
  end
end