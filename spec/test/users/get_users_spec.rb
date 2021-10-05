# frozen_string_literal: true

describe 'Users tests - GET method' do
  it 'get all users' do
    response = users_requests.get_all_users

    expect(response.code).to eql 200
    expect(response.parsed_response['quantidade']).to be > 0
  end

  it 'validates the json schema' do
    response_get_users = users_requests.get_all_users
    response = users_requests.get_user_by_id(response_get_users.parsed_response['usuarios'][0]['_id'])

    expect(response.body).to match_json_schema('users/get_user')
  end

  it 'get a user by id' do
    response_get_users = users_requests.get_all_users
    response = users_requests.get_user_by_id(response_get_users.parsed_response['usuarios'][0]['_id'])

    expect(response.code).to eql 200
    expect(response.parsed_response['nome']).to eql response_get_users.parsed_response['usuarios'][0]['nome']
    expect(response.parsed_response['email']).to eql response_get_users.parsed_response['usuarios'][0]['email']
    expect(response.parsed_response['password']).to eql response_get_users.parsed_response['usuarios'][0]['password']
    expect(response.parsed_response['administrador'])
      .to eql response_get_users.parsed_response['usuarios'][0]['administrador']
  end
end
