require 'cinch'
require 'wolfram'

module Cinch
	module Plugins
		class Calculator
			include Cinch::Plugin

			set plugin_name: "Calculator",
				help: %-The calculator that knows it all. Use ".c <query>" to calculate just about anything-

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
					for pod in hash[:pods]
						if pod[:title] == "Results"
							m. reply pod[:subpods][0][:plaintext]
						end
					end
	      			m.reply 
				rescue
	      			m.reply "Computer says no..."
				end
      end
		end
	end
end
