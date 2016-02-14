require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
require_relative 'ikea/catalogue/generator'
require_relative 'ikea/catalogue/parser'
require_relative '../ext/CParser/CParser'
include CParser

puts 'Generating catalogue...'

start_time = Time.now
IKEA::Catalogue::Generator.generate('ikea_catalogue.txt')
puts "  --> Done in #{(Time.now - start_time).to_i}s"

puts 'Parsing catalogue with Ruby...'

start_time = Time.now
catalogue = IKEA::Catalogue::Parser.parse('ikea_catalogue.txt')
puts "  --> Done in #{((Time.now - start_time) / 60.0).to_i}min"

prices = IKEA::Catalogue::Parser.prices_for('Meatballs', catalogue)
prices.each { |country, price| puts "#{country} : #{price}" }

puts 'Parsing catalogue with C bound Ruby...'

start_time = Time.now
c_catalogue = parse 'ikea_catalogue.txt'
puts "  --> Done in #{((Time.now - start_time) / 60.0).to_i}s"

prices = IKEA::Catalogue::Parser.prices_for('Meatballs', c_catalogue)
prices.each { |country, price| puts "#{country} : #{price}" }
