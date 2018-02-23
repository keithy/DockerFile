$VERBOSE = false
$DEBUG = false
$PROGRESS = false

#this global options stuff doesnt work yet

class Thord < Thor
  include Thor::Actions
  map "-D" => :debug
  map "-V" => :verbose
  map "-P" => :progress

  desc "debug", "Enable debug output"
  def debug( *args )
    $DEBUG = true
    invoke( args.pop, args )
  end

  desc "verbose", "Enable verbose output"
  def verbose( *args )
    puts args
    $VERBOSE = true
    invoke( args.pop, args )
  end

  desc "progress", "Enable progress bar"
  def progress( *args )
    puts args
    $PROGRESS = true
    invoke( args.pop, args )
  end

  #def self.source_root
  #  File.dirname(__FILE__)
  #end
end
