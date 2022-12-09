class JsonWebToken
    def self.decode(token)
      JWT.decode(token, 'Tadesse')[0]
    end
end