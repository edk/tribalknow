
desc "Update Pre-changeset version objects with changeset data"
namespace :paper_trail do
  task :rebuild_changesets => :environment do
    [Note, Topic, Question, Answer].each do |klass|
      puts "\n#{klass}: "
      klass.find_each do |obj|
        print "id(#{obj.id})-##{obj.versions.size}, "
        obj.versions.each do |ver|
          begin
            obj2 = ver.reify
            if obj2
              ver.object_changes = obj2.send(:changes_for_paper_trail)
              ver.save!
            end
          rescue
            puts "\nException #{$!}"
          end
        end
      end
    end
  end
end
