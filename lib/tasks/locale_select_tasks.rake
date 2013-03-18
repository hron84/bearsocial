require 'rubygems'
require 'open-uri'

# Rake task for importing country names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
# 
# It parses a HTML file from Unicode.org for given locale and saves the 
# Rails' I18n hash in the plugin +locale+ directory
# 
# Don't forget to restart the application when you add new locale to load it into Rails!
# 
# == Example
#   rake import:country_select LOCALE=de
# 
# The code is deliberately procedural and simple, so it's easily
# understandable by beginners as an introduction to Rake tasks power.
# See http://github.com/joshmh/cldr/tree/master/converter.rb for much more robust solution

namespace :import do

  desc "Import locale codes and names for various languages from the Unicode.org CLDR archive. Depends on Hpricot gem."
  task :locale_select do
    require 'yaml'
    begin
      require 'nokogiri'
    rescue LoadError
      puts "Error: Nokogiri library required to use this task (import:country_select)"
      exit
    end
    
    # TODO : Implement locale import chooser from CLDR root via Highline
    
    # Setup variables
    locale = ENV['LOCALE']
    unless locale
      puts "\n[!] Usage: rake import:locale_select LOCALE=de\n\n"
      exit 0
    end

    # ----- Get the CLDR HTML     --------------------------------------------------
    begin
      puts "... getting the HTML file for locale '#{locale}'"
      doc = Nokogiri::HTML( open("http://www.unicode.org/cldr/data/charts/summary/#{locale}.html") )
    rescue => e
      puts "[!] Invalid locale name '#{locale}'! Not found in CLDR (#{e})"
      exit 0
    end


    # ----- Parse the HTML with Hpricot     ----------------------------------------
    puts "... parsing the HTML file"
    countries = { locale => {'locales' => {}} }
    tdns = doc.css('tr td.n')
    #doc.search("//tr").each do |row|
    puts "... searching locale infos"
    tdns.each do |firstcell|
      row = firstcell.parent
      if row.css('td.n')[1] and row.css('td.n')[1].text =~ /^language$/
      #if row.search("td[@class='n'][1]") && 
      #   row.search("td[@class='n'][1]").inner_html =~ /^language$/ && 
      #   row.search("td[@class='g']").inner_html =~ /^[a-z]{2,3}$/

        #code   = row.search("td[@class='g']").inner_text
        code    = row.css('td.g')[0].text
        #code   = code[-code.size, 2]
        code    = code.downcase
        #name   = row.search("td[@class='v']").inner_text
        name    = row.css('td.v')[0].text.strip.capitalize
        #countries << { :code => code.to_sym, :name => name.to_s }
        next if name.downcase == 'no linguistic content'
        countries[locale]['locales'][code] = name
        print " ... #{name}"
      end
    end


    
    # ----- Write the parsed values into file      ---------------------------------
    puts "\n... writing the output"
    filename = File.join(Rails.root, 'config', 'locales', "locale_select.#{locale}.yml")
    filename += '.NEW' if File.exists?(filename) # Append 'NEW' if file exists
    File.open(filename, 'w+') { |f| f.write countries.to_yaml }
    puts "\n---\nWritten values for the locale '#{locale}' into file: #{filename}\n"
    # ------------------------------------------------------------------------------
  end

end
