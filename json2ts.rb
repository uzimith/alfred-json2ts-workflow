require 'net/http'
require 'uri'
require 'json'

STDERR.puts "input: #{ARGV[0]}"

uri = URI.parse('http://json2ts.com/Home/GetTypeScriptDefinition')
request = Net::HTTP::Post.new(uri)
request.body = "ns=root&root=root&code=#{ARGV[0]}"

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end

STDERR.puts response

begin
  json = JSON.parse(response.body, quirks_mode: true).gsub("\r\n", "\n")
  puts json
rescue StandardError => e
  STDERR.puts "error: #{e.message}"
  STDERR.puts "body: #{response.body}"
  puts response.body
end
