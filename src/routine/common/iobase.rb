require './src/common/log_writer.rb'
require './src/common/temp_writer.rb'
class IObase
    include LogWriter
    include TempWriter
end