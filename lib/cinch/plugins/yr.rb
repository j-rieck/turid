# encoding=utf-8
require 'nokogiri'

module Cinch
	module Plugins
		class Yr
			include Cinch::Plugin
			@@places = Array.new

			match /yr\s?(\p{Word}+)?\s?(\p{Word}+)?\s?(\p{Word}+)?/

			def get_places
				File.readlines(Dir.pwd + '/lib/data/noreg.csv').map do |line|
				  @@places.push(line.split(/\t/))
				end
			end

			def find (loc, reg1 = nil, reg2 = nil)
				debug "finding location #{loc}"
				@@places.each do |place|
					# reg2 filter
					unless reg2.nil?
						unless place[7].downcase.match(/\b#{reg2.downcase}\b/u)
							debug "reg2 present and not match fylke"
							next
						end
					end

					# reg1 filter
					unless reg1.nil?
						unless place[6].downcase.match(/\b#{reg1.downcase}\b/u)
							debug "reg1 present and not match kommune"
							unless place[7].downcase.match(/\b#{reg1.downcase}\b/u)
								debug "reg1 present and not match fylke"
								next
							end
						end
					end

					if place[1].downcase.match(/\b#{loc.downcase}\b/u)
						return place[13]
					end
				end

				return "Fant desverre ikke stedet du søkte etter. Prøv et annet"
			end

			def execute(m, loc, reg1, reg2)
				get_places

				if loc.nil?
					m.reply "Bruk: .yr <sted> [<kommune> og eller <fylke>]"
					return
				end

				m.reply find loc, reg1, reg2
			end
		end
	end
end