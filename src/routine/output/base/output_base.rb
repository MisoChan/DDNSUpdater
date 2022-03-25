require './src/routine/output/Interfaces/output_interface.rb'
require './src/routine/common/iobase.rb'
class OutputBase < IObase
    include OutputInterface 

    @config

    def initialize(config)
        @config = config
    end



end