module IKEA
  module Catalogue
    module Generator
      def self.generate(output_file, dict = nil)
        dict = dictionary unless dict
        furniture = generate_furniture(scandinavian_cities, dict, 1_000_000)
        catalogue = generate_catalogue(furniture)
        File.open(output_file, 'w') do |file|
          file.write(catalogue)
        end
      end

      private

      def self.dictionary
        File.read('/usr/share/dict/words').split
      end

      def self.countries
        %w(Sweden Norway Finland Germany France Austria Hungary Croatia)
      end

      def self.cities
        cities_url = 'https://raw.githubusercontent.com/David-Haim/'\
                     'CountriesToCitiesJSON/master/countriesToCities.json'
        source = open(cities_url, &:read)
        JSON.parse(source.force_encoding('UTF-16'))
      end

      def self.scandinavian_cities
        world_cities = cities
        countries = %w(Sweden Norway Finland)
        countries.map { |county| world_cities[county] }.flatten.uniq
      end

      def self.furniture_name(cities, words)
        [cities[rand(cities.count)], words[rand(words.count)]].join(' ')
      end

      def self.generate_furniture(cities, words, count)
        furniture = []
        (0...count).each do |_i|
          description = (0..4).map { |_i| words[rand(words.count)] }.join(' ')
          furniture << [furniture_name(cities, words), description]
        end
        furniture << %w(Meatballs Delicious)
        Hash[furniture]
      end

      def self.generate_catalogue(furniture)
        catalogue = []
        countries.each do |country|
          catalogue << country
          furniture.each do |f, d|
            catalogue << "  #{f} : #{d} (#{rand(1_000_000) / 3000.0})"
          end
        end
        catalogue.join("\n")
      end
    end
  end
end
