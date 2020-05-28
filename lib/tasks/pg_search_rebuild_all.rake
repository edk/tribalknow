namespace :pg_search do

  desc "rebuild/reindex all models"
  task :rebuild_all do
    %w[Answer Question VideoAsset Topic].each do |model|
      puts "pg_search - rebuilding #{model}"
      Rake::Task["pg_search:multisearch:rebuild"].invoke(model)
      Rake::Task["pg_search:multisearch:rebuild"].reenable
    end
  end

end
