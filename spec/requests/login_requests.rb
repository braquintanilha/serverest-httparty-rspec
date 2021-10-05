require_relative 'base_class'

class LoginRequests < Base
    def login(email, password)
        self.class.post('/login', body: { email: email, password: password })
    end

    def get_token(admin = true)
        payload = {
            nome: Faker::Name.name,
            email: Faker::Internet.email,
            password: Faker::Internet.password,
            administrador: "#{admin}"
        }

        response_post_user = users_requests.post_user(payload.to_json)
        response = self.login(payload[:email], payload[:password])
        return response.parsed_response['authorization']
    end
end
