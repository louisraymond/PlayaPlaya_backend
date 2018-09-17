class ApplicationController < ActionController::API

  def current_user
    User.find(token_user_id)
  end

  def issue_token(payload)
    JWT.encode(payload,secret)
  end

  def token
    request.headers['Authorization']
  end

  def token_user_id
      decoded_token.first['id']
  end

  def decoded_token
    if token
      begin
        JWT.decode(token,secret,true)
      rescue JWT.DecodeError
        return[{}]
      end
    else
      [{}]
    end
  end


  def user_id_token
    issue_token({ id:token}, secret)
  end

  def  secret
    "lolSecret"
  end

end
