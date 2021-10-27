# frozen_string_literal: true

require_relative 'base_class'

class LoginRequests < Base
  def login(email, password)
    self.class.post('/login', body: { email: email, password: password })
  end

  def get_token(admin: true)
    payload = {
      nome: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      administrador: admin.to_s
    }

    users_requests.post_user(payload)
    response = login(payload[:email], payload[:password])
    response.parsed_response['authorization']
  end
end
