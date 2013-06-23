# encoding=utf-8
require 'nokogiri'
require 'open-uri'
require 'uri'

module Cinch
    module Plugins
        class Yr
            include Cinch::Plugin
            @@places = Array.new

            match /yr\s?(\p{Word}+)?\s?(\p{Word}+)?\s?(\p{Word}+)?/

            def get_places
                File.readlines(Dir.pwd + '/lib/data/noreg.csv', :encoding =>'UTF-8').map do |line|
                  @@places.push(line.split(/\t/))
                end
                @@places.sort_by! {|x,y,z|z}
            end

            def find (loc, reg1 = nil, reg2 = nil)
                # Filtering out unmatched fylke
                unless reg2.nil?
                    @@places.delete_if {|knr, name, pri, tnn, tnb, ten, k, f| not f.match(/\b#{reg2}\b/i)}
                end

                # Filtering out unmatched kommune
                unless reg1.nil?
                    @@places.delete_if {|knr, name, pri, tnn, tnb, ten, k, f| not k.match(/\b#{reg1}\b/i) and not f.match(/\b#{reg1}\b/i)}
                end

                # Filtering out unmatched place
                @@places.delete_if {|knr, name| not name.match(/#{loc}/i)}

                @@places.each do |place|
                    if place[1].match(/#{loc}/i)
                        return place[12]
                    end
                end

                return nil
            end

            def forecast (uri)
                begin
                    doc             = Nokogiri::XML(open(URI.encode(uri)))
                    name            = doc.css('location name').text
                    temperature     = doc.css('observations weatherstation:first temperature').attr('value')
                rescue OpenURI::HTTPError
                    return "Får ikke kontakt med yr.no :/"
                rescue NoMethodError
                    return "No data found - shit isn't working - blahblabhblah"
                end

                begin
                    windDirection   = doc.css('observations weatherstation:first windDirection').attr('name')
                    windSpeed       = doc.css('observations weatherstation:first windSpeed').attr('mps')
                    windDataString  = "Vind #{windSpeed} m/s #{windDirection}."
                rescue NoMethodError
                    debug "No wind data gotten, fucker!"
                end

                if windDataString.nil?
                    return "#{name}: For øyeblikket #{temperature}°C"
                else
                    return "#{name}: For øyeblikket #{temperature}°C. #{windDataString}"
                end
            end

            def execute(m, loc, reg1, reg2)
                get_places

                if loc.nil?
                    m.reply "Bruk: .yr <sted> [<kommune> og eller <fylke>]"
                    return
                end

                uri = find loc, reg1, reg2

                unless uri.nil?
                    m.reply forecast uri
                    return
                end

                m.reply "Fant desverre ikke stedet du søkte etter. Prøv et annet"
            end
        end
    end
end