desc 'This task polls the mail server'
task :mail => :environment do
  puts 'Fetching new mail...'
  Listing.fetch
  puts 'done.'
end