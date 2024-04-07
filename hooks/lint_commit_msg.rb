# Import library
require 'fileutils'

def validate_commit_msg
  root_dir = FileUtils.pwd

  commit_file = File.join(root_dir, '.git/COMMIT_EDITMSG')
  commit_msg = File.read(commit_file) if File.exist?(commit_file)

  regex = /^[A-Z][a-z]+: .{10,100}$/

  if commit_msg
    if commit_msg.match?(regex)
      puts 'Nice commit message ^._.^'
    else
      puts 'Invalid commit message format T^T.'
      puts "Please follow the pattern: 'Category: Brief description (10-100 characters).'"
      exit(1)
    end
  else
    puts 'Commit message file not found'
  end
end

validate_commit_msg
