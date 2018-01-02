Then /^the example(s)? should( all)? pass$/ do |_, _|
  step %q{the exit status should be 0}
  step %q{the output should contain "0 failures"}
end
