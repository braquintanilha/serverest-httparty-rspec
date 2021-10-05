# frozen_string_literal: true

describe 'Products tests - DELETE method' do
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

  it 'delete a product' do
    response = products_requests.delete_product(@token, @product_id)

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Registro excluído com sucesso'
  end

  it 'validates the json schema' do
    response = products_requests.delete_product(@token, @product_id)

    expect(response.body).to match_json_schema('products/delete_product')
  end

  it 'error by product used in a cart' do
    cart_payload = load_fixture('cart')
    cart_payload['produtos'][0]['idProduto'] = @product_id
    carts_requests.post_cart(@token, cart_payload)
    response = products_requests.delete_product(@token, @product_id)

    expect(response.code).to eql 400
    expect(response.parsed_response['message']).to eql 'Não é permitido excluir produto que faz parte de carrinho'
  end

  it 'error by unauthorized user' do
    token = login_requests.get_token(admin: false)
    response = products_requests.delete_product(token, @product_id)

    expect(response.code).to eql 403
    expect(response.parsed_response['message']).to eql 'Rota exclusiva para administradores'
  end

  it 'error by invalid token' do
    response = products_requests.delete_product(Faker::Lorem.word, @product_id)

    expect(response.code).to eql 401
    expect(response.parsed_response['message'])
      .to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
  end

  it 'error by null token' do
    response = products_requests.delete_product('', @product_id)

    expect(response.code).to eql 401
    expect(response.parsed_response['message'])
      .to eql 'Token de acesso ausente, inválido, expirado ou usuário do token não existe mais'
  end
end
