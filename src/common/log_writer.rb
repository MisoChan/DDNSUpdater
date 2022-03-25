#!/usr/bin/env ruby
require 'logger'
require 'date'

module LogWriter

    @@log = Logger.new("./log/#{Date.today}.log")

    def write_info_log(message)
        @@log.level=Logger::INFO
        @@log.info(message)
        
    end

    def write_log_title(message)
        @@log.level=Logger::INFO
        write_unknown_log(false,"="*10+" #{message} "+"="*10)
    end

    def write_warn_log(message)
        @@log.level=Logger::INFO
        @@log.warn(message)
    end


    def write_error_log(message)
        @@log.level=Logger::FATAL
        @@log.error(message)
    end

    def write_critical_log(message)
        @@log.level=Logger::FATAL
        @@log.fatal(message)

    end

    def write_unknown_log(isfatal,message)
        @@log.level = isfatal ? Logger::FATAL : Logger::INFO
        @@log.unknown(message)

    end
end