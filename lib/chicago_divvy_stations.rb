require "chicago_divvy_stations/version"
require "unirest"

module ChicagoDivvyStations
  class Station
    attr_accessor :id, :station_name, :total_docks, :address, :docks_in_service

    def initialize(hash)
      @id = hash["id"]
      @station_name = hash["station_name"]
      @total_docks = hash["total_docks"]
      @address = hash["address"]
      @docks_in_service = hash["docks_in_service"]
    end

    def self.all
      collection = []
      Unirest.get("https://data.cityofchicago.org/resource/aavc-b2wj.json").body.each do |station_hash|
        collection << Station.new(station_hash)
      end
      collection
    end

    def self.find(params_id)
      Station.new(Unirest.get("https://data.cityofchicago.org/resource/aavc-b2wj.json?id=#{params_id}").body)
    end
  end  
end
