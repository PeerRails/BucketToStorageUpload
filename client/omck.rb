# omckclient
class Omck
    attr_accessor :host, :key
    def initialize(params={host: nil, key: nil})
        @host = params[:host]
        @key = params[:key]
    end

    def test_connect
        url = "http://#{@host}/api/v1/channels/twitch/omcktv.json"
        begin
            uri = URI.parse(url)
            response = Net::HTTP.get(uri)
            if response["error"].nil?
                puts "Successful"
            end
        rescue => e
            puts e
        end
    end

    def connect(method="", action="", options="")
      url = "http://#{@host}/api/v1/#{action}"
      response = nil
      5.times do
        begin
          uri = URI.parse(url)
          if method == "post"
            req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
            req.body = options.to_json
          else
            req = Net::HTTP::Get.new(uri)
          end
          req['API_TOKEN'] = @key
          response = Net::HTTP.start(uri.hostname, uri.port){|http| http.request(req)}.body
          break
        rescue => e
          puts e
        end
      end
      res = response.nil? ? "" : JSON.parse(response)
      return res
    end
end