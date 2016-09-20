require 'net/http'
require 'uri'
require 'json'
require_relative 'uploaders/uploader'
require_relative 'uploaders/file'
require_relative 'client/video_api'

# videofile class
class Videofile
    attr_accessor :token, :path, :id, :url, :description
    def initialize(video)
        @token = video["token"]
        @path = video["path"]
        @id = video["id"]
        @url = "null"
        @description = video["description"]
    end
end

client = VideosOmck.new({host: "localhost:3000", key: "eb7ae3dad537"})
client.up
