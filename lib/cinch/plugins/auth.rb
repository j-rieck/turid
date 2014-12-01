#!/bin/env ruby
# encoding: utf-8

require 'cinch'

module Cinch
  module Plugins
    class Auth
      include Cinch::Plugin

      match(/user reg (\S+) (\S+)/, method: :register)
      match(/user auth (\S+) (\S+)/, method: :authenticate)

      def register(m, user, password)
        $db.execute <<-SQL

        SQL
      end

      def authenticate(m, user, password)

      end

    end
  end
end