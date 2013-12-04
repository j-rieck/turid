require 'cinch'

require 'bundler/setup'
require 'elasticsearch'

require_relative '../../../utils/ESLogger'

module Cinch
  module Plugins
    class Log
      include Cinch::Plugin

      listen_to :disconnect, :method => :cleanup
      listen_to :channel,    :method => :log_public_message
      timer 60,              :method => :check_midnight

      def initialize(*args)
        super
        @timeformat       = config[:timeformat]       || "%H:%M:%S"
        @logformat        = config[:format]           || "%{time} <%{nick}> %{msg}"
        @midnight_message = config[:midnight_message] || "=== The dawn of a new day: %Y-%m-%d ==="
        @last_time_check  = Time.now

        logger = ESLogger.new

        bot.debug("lol")
      end

      def cleanup(*)
        @logfile.close
        bot.debug("Closed message logfile.")
      end

      def check_midnight
        time = Time.now
        @logfile.puts(time.strftime(@midnight_message)) if time.day != @last_time_check.day
        @last_time_check = time
      end

      def log_public_message(msg)
        time = Time.now.strftime(@timeformat)
        bot.debug (sprintf(
                            @logformat,
                            :time => time,
                            :nick => msg.user.name,
                            :msg  => msg.message)
        )

      end

    end
  end
end