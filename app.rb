require 'net/http'
require 'uri'
require 'json'
require_relative 'uploaders/uploader'
require_relative 'uploaders/file'
require_relative 'client/video_api'

# videofile class
class Videofile
    attr_accessor :token, :path, :id, :url
    def initialize(video)
        @token = video["token"]
        @path = video["path"]
        @id = video["id"]
        @url = "null"
    end
end

client = VideosOmck.new({host: "localhost:3000", key: "eb7ae3dad537"})
tokens = client.get_vpath(client.get_videos["videos"].map{|v| v["token"] unless v["token"].nil?}).map{|v| v unless v["path"].nil?}
puts client.check_path tokens
