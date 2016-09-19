class FileUploader < Uploader
    def upload
        puts "Uploading File #{@video.path}"
    end
end