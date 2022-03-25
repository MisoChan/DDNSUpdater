require 'fileutils'

module TempWriter
    
    @@temp_file_path = "./tmp/DDNSUpdater.tmp"


    def init()
        if !File.exist?(@@temp_file_path)
            regenerate_file()
        end
    end

    def regenerate_file()
        open(@@temp_file_path, 'w') do |file| 
                JSON.dump({},file)
            end 
    end 
    def read_temporary_data()
        init()
        
        temp_string=""
        File.readlines(@@temp_file_path,chomp: true).each do |line| 
            temp_string = temp_string + line
            
        end
        begin 
            temp_data = JSON.parse(temp_string,symbolize_names: true) 
        rescue JSON::ParserError
            regenerate_file()
            temp_data = {}
        end



        return temp_data
    end

    def write_temporary_data(key,value)
        data = read_temporary_data()
        data[key] = value

        file = open(@@temp_file_path, 'w') do |file| 
            JSON.dump(data,file)
        end 
        

    end
end