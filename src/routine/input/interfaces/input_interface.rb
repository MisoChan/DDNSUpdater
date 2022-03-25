module InputInterface
    def set_config(config_dir)
        raise NotImplementedError.new("#{self.class} is not Implemented #{__method__} ")
    end

    def execute_read()
        raise NotImplementedError.new("#{self.class} is not Implemented #{__method__} ")
    end 
end