require 'net/https'
require 'json'

module DNSPod
  # produce a Net::HTTP POST
  class Post
    def initialize(path, data = nil)
      @uri = URI(File.join(API_URL, path))
      data = data.nil? ? DNSPod::Public.new.get : DNSPod::Public.new.get.merge(data)
      @data = URI.encode_www_form(data)
    end

    def put
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.read_timeout = 10
      http.use_ssl = true
      resp = http.post(@uri.path, @data, 'User-Agent' => DNSPod::User_Agent)
      if resp.body =~ %r{<code>(-)?(\d+)</code>}
        neg = Regexp.last_match(1) || ''
        DNSPod::Exception.new(neg + Regexp.last_match(2))
      else
        json = JSON.parse(resp.body)
        code = json['status']['code']
        if code == '1'
          json
        else
          DNSPod::Exception.new(code)
        end
      end
    end
  end
end
