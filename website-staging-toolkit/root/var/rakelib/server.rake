namespace :server do

  desc "Search for all websites served"
  task :find do
  end
  
  desc "Deploy (atomically) flip rehearsal-site into production-site"
	  task :deploy => :is_deploy_valid do

  end

  desc "Rollback (atomically) flip back production to rehearsal"
  task :rollback => :is_rollback_valid do

  end

end

