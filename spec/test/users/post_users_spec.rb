# frozen_string_literal: true

describe 'Users tests - POST method' do
  before(:each) do
    @payload = {
      nome: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      administrador: Faker::Boolean.boolean.to_s
    }
  end

  it 'create a user' do
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 201
    expect(response.parsed_response['message']).to eql 'Cadastro realizado com sucesso'
  end

  it 'validates the json schema' do
    response = users_requests.post_user(@payload)

    expect(response.body).to match_json_schema('users/post_user')
  end

  it 'error by e-mail already existing' do
    response_get_users = users_requests.get_all_users
    @payload['email'] = (response_get_users.parsed_response['usuarios'][0]['email']).to_s
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['message']).to eql 'Este email já está sendo usado'
  end

  it 'error by user without name' do
    @payload.delete(:nome)
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['nome']).to eql 'nome é obrigatório'
  end

  it 'error by user without e-mail' do
    @payload.delete(:email)
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['email']).to eql 'email é obrigatório'
  end

  it 'error by user without password' do
    @payload.delete(:password)
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['password']).to eql 'password é obrigatório'
  end

  it 'error by user without administrator info' do
    @payload.delete(:administrador)
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['administrador']).to eql 'administrador é obrigatório'
  end

  it 'error by user without any info' do
    @payload = {}
    response = users_requests.post_user(@payload)

    expect(response.code).to eql 400
    expect(response.parsed_response['nome']).to eql 'nome é obrigatório'
    expect(response.parsed_response['email']).to eql 'email é obrigatório'
    expect(response.parsed_response['administrador']).to eql 'administrador é obrigatório'
    expect(response.parsed_response['password']).to eql 'password é obrigatório'
  end
end
