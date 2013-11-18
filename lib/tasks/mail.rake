desc 'This task polls the mail server'
task :poll do
  puts 'Fetching new mail...'
  Listing.fetch
  puts 'done.'
end