class Cookies
    attr_reader :name, :price, :description

    def initialize(name, price, description)
        @name, @price, @description = name, price, description
    end
end
