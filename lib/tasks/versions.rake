namespace :tunnelscrambler do
  namespace :versions do
    desc 'Create the roles'
    task :clean => :environment do |variable|
      Tenant.all.each do |tenant|
        tenant.switch!
        puts "cleaning old versions for #{tenant.domain}"
        PaperTrail::Version.where("created_at < ?", 1.week.ago).delete_all
      end
    end
  end
end