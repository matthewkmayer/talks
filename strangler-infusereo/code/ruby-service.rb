require 'sinatra'
require 'json'

set :port, 9494

$users=[{name: 'foo', id: 1}]

$delegate_user_call=false

get "/v1/user" do
  content_type :json
  $users.to_json
end

get "/v1/user/:id" do
  if ($delegate_user_call)
    # call golang endpoint and return it
  end

  content_type :json
  user = get_user_by_id(params[:id].to_i)
  if user != nil
    return user.to_json
  end
  return 404
end

def get_user_by_id (id)
  $users.find{|user| user[:id] == id}
end
