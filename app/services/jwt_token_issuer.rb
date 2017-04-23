class JwtTokenIssuer

  def self.generate_token(user_id)
    payload = { user_id: user_id }
    JWT.encode payload, ENV['JWT_HMAC_SECRET'], ENV['JWT_ALG']
  end
  
  def self.user_from_token(token)
    begin
      decoded_token = JWT.decode token, ENV['JWT_HMAC_SECRET'], true, { algorithm: ENV['JWT_ALG'] }
      puts decoded_token[0]
      user_id = decoded_token[0]["user_id"]
      User.find(user_id)
    rescue
      nil
    end
  end

end
