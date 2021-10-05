describe 'Procuts tests - POST method' do
    before(:each) do
        @payload = {
            nome: Faker::Commerce.product_name,
            preco: Faker::Number.number,
            descricao: Faker::Lorem.sentence,
            quantidade: Faker::Number.number
        }

        @token = login_requests.get_token()
    end

    it 'create a product' do
        response = products_requests.post_product(@token, @payload)

        expect(response.code).to eql 201
        expect(response.parsed_response['message']).to eql 'Cadastro realizado com sucesso'
    end

    it 'validates the json schema' do
        response = products_requests.post_product(@token, @payload)
        
        expect(response.body).to match_json_schema('products/post_product')
    end

    it 'error by product name already existing' do
        product = load_fixture('product')
        payload_product = @payload
        payload_product[:nome] = product['mouse']['nome']

        response = products_requests.post_product(@token, payload_product)

        expect(response.code).to eql 400
        expect(response.parsed_response['message']).to eql 'Já existe produto com esse nome'
    end

    it 'error by unauthorized user' do
        token = login_requests.get_token(false)
        response = products_requests.post_product(token, @payload)

        expect(response.code).to eql 403
        expect(response.parsed_response['message']).to eql 'Rota exclusiva para administradores'
    end
    
    it 'error by invalid token' do
        response = products_requests.post_product(Faker::Lorem.word, @payload)

        expect(response.code).to eql 401
        expect(response.parsed_response['message']).to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
    end
    
    it 'error by null token' do
        response = products_requests.post_product('', @payload)

        expect(response.code).to eql 401
        expect(response.parsed_response['message']).to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
    end
end
