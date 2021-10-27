# frozen_string_literal: true

describe 'Products tests - PUT method' do
  before(:each) do
    @payload = {
      nome: Faker::Commerce.product_name,
      preco: Faker::Number.number,
      descricao: Faker::Lorem.sentence,
      quantidade: Faker::Number.number
    }

    @token = login_requests.get_token
    response_post_product = products_requests.post_product(@token, @payload)
    @product_id = response_post_product.parsed_response['_id']
  end

  it 'edit a product' do
    @payload['nome'] = Faker::Commerce.product_name

    response = products_requests.put_product(@token, @product_id, @payload)

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Registro alterado com sucesso'
  end

  it 'validates the json schema' do
    @payload['nome'] = Faker::Commerce.product_name

    response = products_requests.put_product(@token, @product_id, @payload)

    expect(response.body).to match_json_schema('products/put_product')
  end

  it 'create a product with put method' do
    @payload['nome'] = Faker::Commerce.product_name

    response = products_requests.put_product(@token, Faker::Alphanumeric.alphanumeric, @payload)

    expect(response.code).to eql 201
    expect(response.parsed_response['message']).to eql 'Cadastro realizado com sucesso'
  end

  it 'error by unauthorized user' do
    token = login_requests.get_token(admin: false)
    response = products_requests.put_product(token, @product_id, @payload)

    expect(response.code).to eql 403
    expect(response.parsed_response['message']).to eql 'Rota exclusiva para administradores'
  end

  it 'error by invalid token' do
    response = products_requests.put_product(Faker::Lorem.word, @product_id, @payload)

    expect(response.code).to eql 401
    expect(response.parsed_response['message'])
      .to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
  end

  it 'error by null token' do
    response = products_requests.put_product('', @product_id, @payload)

    expect(response.code).to eql 401
    expect(response.parsed_response['message'])
      .to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
  end
end
