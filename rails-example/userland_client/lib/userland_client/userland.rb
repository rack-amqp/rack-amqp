module UserlandClient
  class Userland

    def self.get(uri, options={})
      connection.get(uri, options)
    end

    def self.connection
      # Can be used for a connection pool I guess
      new
    end

    def initialize
    end

    def get(uri, options={})
      raise "TODO"
    end
  end
end
