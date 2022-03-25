require './src/routine/input/interfaces/input_interface.rb'
require './src/routine/common/iobase.rb'
class InputBase < IObase

    include InputInterface

    @@config_key=""
    @config


    def initialize(config)
        @config = config
    end

    def get_config_key()
        return @@config_key
    end

end