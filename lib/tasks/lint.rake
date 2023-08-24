desc "Run all linters"
task lint: :environment do
  sh "bundle exec rubocop"
  sh "npm run lint"
end
