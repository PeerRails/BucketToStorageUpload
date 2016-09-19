#Uploader class, takes from lib directory
class Uploader
    def initialize(video, service="file")
        @video = video
        @service = (ENV["UPLOAD_SERVICE"] || service).to_sym
    end

    def upload
        u = Object.const_get("#{@service.capitalize}Uploader").new(@video)
        u.upload
    end
end