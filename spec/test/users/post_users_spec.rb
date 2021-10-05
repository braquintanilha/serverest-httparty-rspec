describe 'Users tests - POST method' do
    before(:each) do
        @payload = {
            nome: Faker::Name.name,
            email: Faker::Internet.email,
            password: Faker::Internet.password,
            administrador: "#{Faker::Boolean.boolean}"
        }
    end

    it 'create a user' do
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 201
        expect(response.parsed_response['message']).to eql 'Cadastro realizado com sucesso'
    end

    it 'validates the json schema' do
        response = users_requests.post_user(@payload.to_json)
        
        expect(response.body).to match_json_schema('users/post_user')
    end

    it 'error by e-mail already existing' do
        response_get_users = users_requests.get_all_users
        @payload['email'] = "#{response_get_users.parsed_response['usuarios'][0]['email']}"
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['message']).to eql 'Este email já está sendo usado'
    end

    it 'error by user without name' do
        response_get_users = users_requests.get_all_users
        @payload.delete(:nome)
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['nome']).to eql 'nome é obrigatório'
    end

    it 'error by user without e-mail' do
        response_get_users = users_requests.get_all_users
        @payload.delete(:email)
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['email']).to eql 'email é obrigatório'
    end

    it 'error by user without password' do
        response_get_users = users_requests.get_all_users
        @payload.delete(:password)
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['password']).to eql 'password é obrigatório'
    end

    it 'error by user without administrator info' do
        response_get_users = users_requests.get_all_users
        @payload.delete(:administrador)
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['administrador']).to eql 'administrador é obrigatório'
    end

    it 'error by user without any info' do
        response_get_users = users_requests.get_all_users
        @payload = {}
        response = users_requests.post_user(@payload.to_json)

        expect(response.code).to eql 400
        expect(response.parsed_response['nome']).to eql 'nome é obrigatório'
        expect(response.parsed_response['email']).to eql 'email é obrigatório'
        expect(response.parsed_response['administrador']).to eql 'administrador é obrigatório'
        expect(response.parsed_response['password']).to eql 'password é obrigatório'
    end
end