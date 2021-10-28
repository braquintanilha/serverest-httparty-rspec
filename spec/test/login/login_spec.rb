# frozen_string_literal: true

describe 'Login tests - POST method' do
  user = load_fixture('user')

  it 'succesfully login' do
    users_requests.post_user(user['valid'])
    response = login_requests.login(user['valid']['email'], user['valid']['password'])

    expect(response.code).to eql 200
    expect(response.parsed_response['message']).to eql 'Login realizado com sucesso'
  end

  it 'validates the json schema' do
    users_requests.post_user(user['valid'])
    response = login_requests.login(user['valid']['email'], user['valid']['password'])

    expect(response.body).to match_json_schema('login/post_login')
  end

  it 'error by incorrect user/password' do
    response = login_requests.login(user['incorrect']['email'], user['incorrect']['password'])

    expect(response.code).to eql 401
    expect(response.parsed_response['message']).to eql 'Email e/ou senha inválidos'
  end

  it 'error by invalid e-mail' do
    response = login_requests.login(user['invalid']['email'], user['valid']['password'])

    expect(response.code).to eql 400
    expect(response.parsed_response['email']).to eql 'email deve ser um email válido'
  end

  it 'error by null e-mail' do
    response = login_requests.login(user['null']['email'], user['valid']['password'])

    expect(response.code).to eql 400
    expect(response.parsed_response['email']).to eql 'email não pode ficar em branco'
  end

  it 'error by null password' do
    response = login_requests.login(user['valid']['email'], user['null']['password'])

    expect(response.code).to eql 400
    expect(response.parsed_response['password']).to eql 'password não pode ficar em branco'
  end
end
