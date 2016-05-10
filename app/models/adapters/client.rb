module Adapters
  class Client
    def run
      connection = Adapters::Connection.new()

      # [{name: , winner: }, {name: , winner: }]
      json = connection.results.each do 
        Game.create(json)
      end
    end
  end
end