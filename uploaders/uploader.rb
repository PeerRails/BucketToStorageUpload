#Uploader class, takes from lib directory
class Uploader
    def initialize(video, service="file")
        @video = video
        @service = (ENV["UPLOAD_SERVICE"] || service).to_sym
        @name = @video.description.gsub(/\s+/, '_') + "." + @video.path.split(".").last
    end

    def upload(path)
        u = Object.const_get("#{@service.capitalize}Uploader").new(@video)
        u.upload(path)
    end
end
