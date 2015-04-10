%w(tunnelscrambler:seeds:tenants
   tunnelscrambler:seeds:roles
   tunnelscrambler:seeds:settings
   tunnelscrambler:seeds:admins
   tunnelscrambler:seeds:pages
   tunnelscrambler:seeds:categories
   tunnelscrambler:seeds:handicaps
   tunnelscrambler:seeds:flyers).each do |name|

  puts "Invoking #{name}"
  Rake::Task[name].invoke
end

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER FOR PUBLIC TENANT: ' << user.name
