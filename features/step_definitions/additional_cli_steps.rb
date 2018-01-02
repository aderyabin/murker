Then /^the example(s)? should( all)? pass$/ do |_, _|
  step %q{the output should contain "0 failures"}
  step %q{the exit status should be 0}
end

Then /^the example(s)? should( all)? fail$/ do |_, _|
  step %q{the exit status should be 1}
end
