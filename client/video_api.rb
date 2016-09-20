require_relative 'omck'

class VideosOmck < Omck
    def get_videos
        connect("get", "videos/unarchived")
    end

    def get_vpath(tokens=[])
        tokens.map{|token| connect("get", "video/#{token}/path")}
    end

    def check_path(video={})
        if File.exists?(video["path"])
            videofile = Videofile.new(video)
            return videofile
        else
            connect("post", "/video/#{video["token"]}/update", {video: {deleted: true, path: nil}})
            puts "Video Not Found \n#{video}\n"
            return nil
        end
    end

    def upload_video(video=nil)
        if video.nil?
            return nil
        else
            u = Uploader.new(video)
            dest = u.upload(ENV["UPLOAD_PATH"] || "/tmp")
            return dest
        end
    end

    def post_update(token, dest)
        connect("post", "/video/#{token}/update", {video: {deleted: true, path: dest}})
    end

    def up
        videos = get_vpath(get_videos["videos"].map{|v| v["token"] unless v["token"].nil?}).map{|v| v unless v["path"].nil?}
        videos.each do |v|
            begin
                videofile = check_path v
                unless videofile.nil?
                    destination = upload_video(videofile)
                    post_update(v.token, destination) unless destination.nil?
                end
            rescue => e
                puts e
            end
        end
    end
end