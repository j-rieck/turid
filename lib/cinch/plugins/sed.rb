require 'date'

module Cinch
	module Plugins
		class Sed
			include Cinch::Plugin

			match /s\/([^\/]+)\/([^\/]+)\/(\w)?/, method: :replace, use_prefix: false
			listen_to :connect, :method => :on_connect
			listen_to :channel, :method => :on_channel

			def initialize(*args)
				super(*args)
				@filemutex = Mutex.new
				self.on_connect
			end

			def replace(m, find, replace, flag)
				unless m.params[1].start_with? "s"
					return
				end

				msg = find_last_message(m.user.nick)
				res = msg[2].gsub(/#{find}/, replace)
				time = Time.at(msg[0].to_i).strftime("%H:%M")
				m.reply "#{time} <#{msg[1]}> #{res}"
			end

			def on_connect(*)
				@filepath = "/tmp/sedlog.data"
				@file = File.open(@filepath, "a+")
				@file.seek(0, File::SEEK_END) # Work around Ruby bug https://bugs.ruby-lang.org/issues/10039

				at_exit{@file.close}
			end

			def on_channel(msg)
				return if msg.message.start_with?("\u0001") # ACTION

				@filemutex.synchronize do
					@file.puts("#{msg.time.to_i}\0#{msg.user.nick}\0#{msg.message.strip}")
				end
			end

			private
			def find_last_message(nick)
				@filemutex.synchronize do
					@file.rewind
					@file.lines.reverse_each do |line|
						parts = line.split("\0")

						if parts[1] == nick && parts[2].match(/^s\//) == nil
							return  parts
						end
					end

					@file.seek(0, File::SEEK_END)
				end

				nil
			end
		end
	end
end