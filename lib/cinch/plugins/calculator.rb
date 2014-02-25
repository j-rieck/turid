require 'cinch'
require 'wolfram'

module Cinch
	module Plugins
		class Calculator
			include Cinch::Plugin

			@@settings_file = Dir.pwd + '/lib/data/calculator.settings.rb'

			def initialize(*args)
        super

        bot.configure do |c|
          c.plugins.options[Cinch::Plugins::Calculator] = eval( File.open(@@settings_file, "rb").read )
        end
        Wolfram.appid = config[:api_key]
			end

			match /c\s(.+)/
      def execute(m, query)
      	result = Wolfram.fetch(query)
      	hash =  Wolfram::HashPresenter.new(result).to_hash
				begin
	      	m.reply hash[:pods]['Result'][0]
				rescue
	      	m.reply "Computer says no..."
				end
      end
		end
	end
end