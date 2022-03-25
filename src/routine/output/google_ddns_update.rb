require './src/routine/output/base/output_base.rb'
require 'net/https'
class GoogleDDNSUpdate < OutputBase

    USER_AGENT= "DDNSUpdater/0.1"

    def execute_output
        
        googleConfig =  @config[:GoogleDDNS]
        write_log_title("BEGIN DDNS REQUEST")
        googleConfig.each do |config|
            
            request_url = "https://domains.google.com/nic/update?hostname=#{config[:DOMAIN]}&myip=#{@config[:ip_addr]}"
            
            
            uri = URI.parse(request_url)
            http = Net::HTTP.new(uri.host, uri.port)

            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            write_info_log("URI:#{request_url} ")
            request = Net::HTTP::Get.new(uri,{'Authorization'=> "Basic base64-encoded-auth-string",'User-Agent' => USER_AGENT})
            request.basic_auth(config[:USER_NAME],config[:PASSWORD])

            response = http.request(request)
            
            
            write_info_log("Response:#{response.body} Status code:#{response.code}")
            
        end
        write_log_title(" END DDNS REQUEST ")
        
        
    end 


end