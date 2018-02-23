require 'open3'

module RIO
  class Rio
    def shell3(*cmd , &block)
      Open3.popen3(*cmd, {:chdir => self.to_s} ) do |stdin, stdout, stderr, thread|
        # read each stream from a new thread
        {:out => stdout, :err => stderr}.each do |key, stream|
          Thread.new do
            until (line = stream.gets).nil? do
              # yield the block depending on the stream
              if key == :out
                yield line, nil, thread if block_given?
              else
                yield nil, line, thread if block_given?
              end
            end
          end
        end

        thread.join # don't exit until the external process is done
      end
    end

    def shell2e(*cmd , &block)
      Open3.popen2e(*cmd, {:chdir => self.to_s} ) do |stdin, oe |
        oe.each &block
      end
    end

    def shell2(*cmd , &block)
      Open3.popen2(*cmd, {:chdir => self.to_s} ) do |stdin, oe |
        oe.each &block
      end
    end
  end
end
#   # check gcc warnings
#   source = "foo.c"
#   Open3.popen2e("gcc", "-Wall", source) {|i,oe,t|
#
#   }