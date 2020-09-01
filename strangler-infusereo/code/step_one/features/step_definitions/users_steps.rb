require 'net/http'
require 'json'
require 'rspec/expectations'

$response = nil

When /^I hit the all users endpoint$/ do
  url = URI.parse('http://localhost:9494/v1/user')
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  $response = res.body

end

When(/^I ask for the details of user (\d+)$/) do |user_id|
  url = URI.parse('http://localhost:9494/v1/user/' + user_id.to_s)
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  $response = res.body
end

Then(/^I should get the details for user (\d+)$/) do |user_id|
  body = JSON.parse($response)
  expect(body['name']).to eq('foo')
  expect(body['id']).to eq(user_id.to_i)
end

Then /^I should get a list of all users$/ do
  body = JSON.parse($response)
  expect(body[0]['name']).to eq('foo')
  expect(body[0]['id']).to eq(1)
end
