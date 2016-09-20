class FileUploader < Uploader
    def upload(path="/tmp")
        dest = "#{path}/#{@name}"
        puts "Uploading File #{@video.path} to #{dest}"
        File.rename(@video.path, dest)
        return dest
    end
end