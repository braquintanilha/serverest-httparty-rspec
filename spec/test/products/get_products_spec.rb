# frozen_string_literal: true

describe 'Products tests - GET method' do
  product = load_fixture('product')

  it 'get all products' do
    response = products_requests.get_all_products

    expect(response.code).to eql 200
    expect(response.parsed_response['quantidade']).to be > 0
  end

  it 'validates the json schema' do
    response = products_requests.get_product_by_id(product['mouse']['_id'])

    expect(response.body).to match_json_schema('products/get_product')
  end

  it 'get a product by id' do
    response = products_requests.get_product_by_id(product['mouse']['_id'])

    expect(response.code).to eql 200
    expect(response.parsed_response['nome']).to eql product['mouse']['nome']
    expect(response.parsed_response['preco']).to eql product['mouse']['preco']
    expect(response.parsed_response['descricao']).to eql product['mouse']['descricao']
  end
end
