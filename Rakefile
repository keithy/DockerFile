# temporary cruft


desc "test"
task :test do
  sh %{ ls }
end

$production = '/Users/Shared/production/'
$rehearsal = '/Users/Shared/rehearsal/'

$rule = File::Find.new(
    :pattern => "index.html",
    :follow  => false,
    :maxdepth => 2,
    :path    => [ $production ]
)

$rule.find do | path |
  puts path
end


class Sites < Rake::Task
  def self.all
    #rio('/Users/Shared/production').all.files('content.php').collect { | key | self.new( key )}
    #too slow try -
    #sh "find '/Users/Shared/production' -name PrivacyPolicy.php -maxdepth 4".lines.collect { | key | self.new( key )}
    #Rake::.sh %{ ls '/Users/Shared/production/trial.churchedit.co.uk/trial' }. split("\n").collect { | key | self.new( key )}
  end
  def initialize( path_to_key )
    @home = rio( path_to_key )
  end
  def to_s
    @home.to_s
  end
end
