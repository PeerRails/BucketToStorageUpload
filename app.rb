require 'net/http'
require 'uri'
require 'json'
require_relative 'uploaders/uploader'
require_relative 'uploaders/file'
require_relative 'client/video_api'

HOST = ENV["OMCK_HOST"] || "localhost:3000"
KEY = ENV["OMCK_KEY"] || "eb7ae3dad537"

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

loop do
    if File.exists?('.start') and Time.now.strftime("%H").to_i < 1
        client = VideosOmck.new({host: HOST, key: KEY})
        puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} Starting..."
        client.up
        `rm .start`
    elsif !File.exists?('.start') and Time.now.strftime("%H").to_i > 22
        `touch .start`
    end
    sleep(600)
end
