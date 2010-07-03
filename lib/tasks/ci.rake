desc "Continues Integration helpers"
task :ci do
  spec = "script/spec spec/"
  puts "\nRun specs: %s" % spec
  system spec
  
  cucumber = "script/cucumber features"
  puts "\nRun cukes: %s" % cucumber
  system cucumber
end