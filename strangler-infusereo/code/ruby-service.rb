require 'sinatra'
require 'json'
require 'net/http'

set :port, 9494

$users=[{name: 'foo', id: 1}]

$delegate_user_call=false

get "/v1/user" do
  content_type :json
  $users.to_json
end

get "/v1/user/:id" do
  content_type :json
  if ($delegate_user_call)
    # call golang endpoint and return it
    url = URI.parse('http://localhost:8080/v1/users/' + params[:id].to_s)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    return res.body # already in JSON
  end

  user = get_user_by_id(params[:id].to_i)
  if user != nil
    return user.to_json
  end
  return 404
end

def get_user_by_id (id)
  $users.find{|user| user[:id] == id}
end
