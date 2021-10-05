# frozen_string_literal: true

describe 'Users tests - PUT method' do
  before(:each) do
    @payload = {
      nome: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      administrador: Faker::Boolean.boolean.to_s
    }

    @response_post_user = users_requests.post_user(@payload.to_json)
    @user_id = @response_post_user.parsed_response['_id']
  end

  it 'edit a user' do
    @payload['email'] = Faker::Internet.email

    response = users_requests.put_user(@user_id, @payload.to_json)

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Registro alterado com sucesso'
  end

  it 'validates the json schema' do
    @payload['email'] = Faker::Internet.email

    response = users_requests.put_user(@user_id, @payload.to_json)

    expect(response.body).to match_json_schema('users/put_user')
  end

  it 'create a user with put method' do
    @payload['email'] = Faker::Internet.email

    response = users_requests.put_user(Faker::Alphanumeric.alpha(number: 10), @payload.to_json)

    expect(response.code).to eql 201
    expect(response.parsed_response['message']).to eql 'Cadastro realizado com sucesso'
  end

  it 'error by e-mail already existing' do
    response_get_users = users_requests.get_all_users
    @payload['email'] = response_get_users.parsed_response['usuarios'][0]['email']

    response = users_requests.put_user(@user_id, @payload.to_json)

    expect(response.code).to eql 400
    expect(response.parsed_response['message']).to eql 'Este email já está sendo usado'
  end
end
