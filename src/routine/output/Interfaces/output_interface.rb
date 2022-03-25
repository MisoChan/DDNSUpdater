module OutputInterface

    def execute_output()
        raise NotImplementedError.new("#{self.class} is not Implemented #{__method__} ")
    end 

end