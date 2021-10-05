# frozen_string_literal: true

describe 'Users tests - DELETE method' do
  before(:each) do
    payload = {
      nome: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      administrador: Faker::Boolean.boolean.to_s
    }

    response_post_user = users_requests.post_user(payload.to_json)
    @response_login = login_requests.login(payload[:email], payload[:password])
    @user_id = response_post_user.parsed_response['_id']
  end

  it 'delete a user' do
    response = users_requests.delete_user(@user_id)

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Registro excluído com sucesso'
  end

  it 'validates the json schema' do
    response = users_requests.delete_user(@user_id)

    expect(response.body).to match_json_schema('users/delete_user')
  end

  it 'error by cart created' do
    cart_payload = load_fixture('cart')
    carts_requests.post_cart(@response_login.parsed_response['authorization'], cart_payload)
    response = users_requests.delete_user(@user_id)

    expect(response.code).to eql 400
    expect(response.parsed_response['message']).to eql 'Não é permitido excluir usuário com carrinho cadastrado'
  end

  it 'error by invalid id' do
    response = users_requests.delete_user(Faker::Alphanumeric.alpha(number: 10))

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Nenhum registro excluído'
  end
end
