require 'net/http'
require 'uri'
require 'json'

code = ARGV[0]

STDERR.puts "input: #{code}"

uri = URI.parse('http://json2ts.com/Home/GetTypeScriptDefinition')
request = Net::HTTP::Post.new(uri)
request.body = "ns=root&root=root&code=#{code}"

response = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(request)
end

begin
  puts JSON.parse(response.body, quirks_mode: true).gsub("\r\n", "\n")
rescue StandardError => e
  STDERR.puts "error: #{e.message}"
  STDERR.puts "body: #{response.body}"
  puts response.body
end
