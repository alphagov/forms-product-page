desc "Run tests"
task test: :environment do
  sh "bundle exec rspec"
end
