desc 'This task polls the mail server'
task :mail do
  puts 'Fetching new mail...'
  Listing.fetch
  puts 'done.'
end