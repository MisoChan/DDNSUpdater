
require './src/routine/input/ipaddress_resolver.rb'
require './src/routine/output/google_ddns_update.rb' 
require 'json'

require './src/common/log_writer.rb'
require './src/common/temp_writer.rb'

include LogWriter

class DDNSUpdater
    # PID filepath
    @@pid_filepath = "./ddns_daemon.pid"  
    #config data
    @@config_data = {}

    def initialize
        # interrupt
        @interrupt_flag = false

    end
    def run()
        config_string = ""
        File.readlines("./config/settings.json",chomp: true).each do |line| 
            config_string = config_string + line
        end
        @@config_data = JSON.parse(config_string,symbolize_names: true)
        
        #TODO: WIP on 2022/03/25
        # daemonize
        # set_trap

        execute
       
    end

    def execute


        begin 
            ipaddr_resolver = IpAddressResolver.new(@@config_data)
            google_ddns_updater = GoogleDDNSUpdate.new(@@config_data)
            
            loop do
                
                write_log_title("Process Start: #{ipaddr_resolver.get_config_key()} ")
                
                result = ipaddr_resolver.execute_read()
                
                if result
                     google_ddns_updater.execute_output()
                end

                write_log_title("Process End: #{ipaddr_resolver.get_config_key()} ")

                write_info_log("Next Update action at #{Time.now + @@config_data[:General][:GLOBAL_IP_UPDATE_INTERVAL_SECONDS]}")
                sleep @@config_data[:General][:GLOBAL_IP_UPDATE_INTERVAL_SECONDS]
            end

        rescue Exception => ex
            write_critical_log(ex)
            puts ex
            exit 1
        end

    end

    def daemonize
        begin
            # Daemonaize
            # ( RUBY_VERSION < 1.9 )
            # exit!(0) if Process.fork
            # Process.setsid
            # exit!(0) if Process.fork
            # ( RUBY_VERSION >= 1.9 )
            Process.daemon(true, true)


            # generate PID file
            open(@@pid_filepath, 'w+') do |f| 
                f << Process.pid
            end
            write_info_log("Daemon started... pid:#{Process.pid}")
        rescue => ex
            write_critical_log(ex)
        end
    end

    # Trap interrupt
    def set_trap
        begin
            Signal.trap(:INT)  {@flag_int = true}  # SIGINT  
            Signal.trap(:TERM) {@flag_int = true}  # SIGTERM 
        rescue => e
            write_critical_log("#{self.class.name}.set_trap #{e}")
            exit 1
        end
    end
end