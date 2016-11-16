module IKEA
  module Catalogue
    module Parser
      def self.parse(file)
        catalogue_to_hash(File.read(file).split("\n"))
      end

      def self.prices_for(item, catalogue)
        country_prices = []
        catalogue.each do |country, prices|
          country_prices << [country, prices[item]] if prices[item]
        end
        Hash[country_prices]
      end

      private

      def self.catalogue_to_hash(catalogue)
        active_country = ''
        prices = {}

        catalogue.each do |line|
          data = line.scan(/^\s\s(.+)\s\:\s(.+)\s\((.+)\)$/)
          if data.empty?
            active_country = line
            prices[active_country] ||= {}
          else
            item, description, price = data.first
            prices[active_country][item] = {
              description: description,
              price: price.to_f
            }
          end
        end

        prices
      end
    end
  end
end
