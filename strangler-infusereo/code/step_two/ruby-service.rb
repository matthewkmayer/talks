require 'sinatra'
require 'json'
require 'net/http'

set :port, 9494
set :bind, '0.0.0.0'

@@users = [{ name: 'foo', id: 1 }]

@@delegate_user_call = true

get '/v1/user' do
  content_type :json
  @@users.to_json
end

get '/v1/user/:id' do
  content_type :json
  if @@delegate_user_call
    # call golang endpoint and return it
    puts "\nDelegating /v1/users/ call to Golang app"
    url = URI.parse('http://localhost:8080/v1/users/' << params[:id])
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    return res.body # already in JSON
  end

  user = get_user_by_id(params[:id].to_i)
  return (user.nil? ? 404 : user.to_json)
end

def get_user_by_id(id)
  @@users.find { |user| user[:id] == id }
end
