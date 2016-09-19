require_relative 'omck'

class VideosOmck < Omck
    def get_videos
        connect("get", "videos/unarchived")
    end

    def get_vpath(tokens=[])
        tokens.map{|token| connect("get", "video/#{token}/path")}
    end

    def check_path(videos=[])
        output = []
        videos.each do |v|
            if File.exists?(v["path"])
                videofile = Videofile.new(v)
                u = Uploader.new(videofile)
                u.upload
            else
                connect("post", "/video/#{v["token"]}/update", {video: {deleted: true, path: nil}})
                puts "Video Not Found \n#{v}\n"
            end
        end
    end
end