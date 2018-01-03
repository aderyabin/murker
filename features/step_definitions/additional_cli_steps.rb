Then /^the example(s)? should( all)? pass$/ do |_, _|
  step %q{the output should contain "0 failures"}
  step %q{the exit status should be 0}
end

Then /^the example(s)? should( all)? fail$/ do |_, _|
  step %q{the exit status should be 1}
end

Then /^the output should contain (failures|these lines):$/ do |_, lines|
  out = all_output.dup
  lines.split(/\n/).map(&:strip).each do |line|
    next if line.blank?
    expect(out).to match /#{Regexp.escape(line)}/
    out.gsub!(/.*?#{Regexp.escape(line)}/m, '')
  end
end
