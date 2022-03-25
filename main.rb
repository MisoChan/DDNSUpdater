
require './src/routine/input/ipaddress_resolver.rb'
require './src/routine/output/google_ddns_update.rb' 
require 'json'
require './src/DDNSUpdater.rb'
require './src/common/log_writer.rb'
require './src/common/temp_writer.rb'

include LogWriter


begin 
    routine = DDNSUpdater.new()
    routine.run()
rescue Exception => ex
    write_critical_log(ex)
    puts ex.backtrace
end
