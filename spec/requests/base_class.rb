require 'httparty'

class Base
    include HTTParty
    base_uri 'https://serverest.dev'
end
