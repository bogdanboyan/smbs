desc "Run all acceptance and unit tests"
task :ci do
  spec = "rspec spec/"
  puts "\nRun specs: %s" % spec
  system spec
  
  cucumber = "script/cucumber features/"
  puts "\nRun cukes: %s" % cucumber
  system cucumber
end