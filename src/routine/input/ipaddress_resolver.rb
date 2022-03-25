
require './src/routine/input/base/input_base.rb'
require 'resolv'
require './src/routine/common/iobase.rb'
class IpAddressResolver < InputBase

    @@config_key = :IP_RESOLVER

    @is_changed_ip = false
    def execute_read
        old_ipaddr =  read_temporary_data()[:ip_addr]
        ip_addr = Resolv::DNS.new(:nameserver=>'ns1.google.com').getresources("o-o.myaddr.l.google.com", Resolv::DNS::Resource::IN::TXT)[0].strings[0]
        write_info_log("Your global IP address is #{ip_addr}.")


        if (old_ipaddr != ip_addr) or (old_ipaddr == nil)
            write_info_log("Global IP address has changed. #{old_ipaddr} -> #{ip_addr} ")
            @is_changed_ip = true
        else
            write_info_log("Global IP address has not changed.")
        end
        
        write_temporary_data(:ip_addr,ip_addr)
        @config[:ip_addr] = ip_addr
        return  @is_changed_ip
    end


end