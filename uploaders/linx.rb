# Linx Uploader
# https://github.com/andreimarcu/linx-server
class LinxUploader < Uploader
    def upload(path="https://media.omck.moe/upload/")
        api_key = ENV["API_KEY"] || ""
        res = `curl -H "Accept: application/json" -H "Linx-Api-Key: #{API_KEY}" -T #{@video.path} #{path}`
        json = JSON.parse(res)
        url = json["url"]
        return url
    end
end