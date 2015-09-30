# Script that obtains various git metrics from a basic git log file
require 'set'
require 'date'

def trimFromBeginning(string, amount)
  string[0..(amount - 1)] = ''
  return string
end

# Given an array of git log lines, count the number of commits in the log
file = File.open('ruby-progressbar-short.txt','r')
long_file = File.open('ruby-progressbar-full.txt','r')
lines = Array.new
long_file.each {|line| lines << line}

def num_commits(lines)
  number_of_commits = 0
  lines.each do |line|
    if line.start_with?('commit ')
      number_of_commits += 1
    end
  end
  number_of_commits
end

puts num_commits lines

# Given an array of git log lines, count the number of different authors
#   (Don't double-count!)
# You may assume that emails make a developer unique, that is, if a developer
# has two different emails they are counted as two different people.
def num_developers(lines)
  developer_count = Array.new
  lines.each do |line|
    if line.start_with?('Author: ')
      line_array = line.split('<')
      # Removes the first element of the array, leaving only the email left
      line_array.shift
      dev = line_array[0]
      # If the developer doesn't already exist in the array, add it
      if !developer_count.include?(dev)
        developer_count << dev
      end
    end
  end
  developer_count.length
end

puts num_developers lines

# Given an array of Git log lines, compute the number of days this was in development
# Note: you cannot assume any order of commits (e.g. you cannot assume that the newest commit is first).
def days_of_development(lines)

end

# This is a ruby idiom that allows us to use both unit testing and command line processing
# Does not get run when we use unit testing, e.g. ruby test_git_metrics.rb
# These commands will invoke this code with our test data:
#    ruby git_metrics.rb < ruby-progressbar-short.txt
#    ruby git_metrics.rb < ruby-progressbar-full.txt
if __FILE__ == $PROGRAM_NAME
  lines = []
  $stdin.each { |line| lines << line }
  puts "Nunber of commits: #{num_commits lines}"
  puts "Number of developers: #{num_developers lines}"
  puts "Number of days in development: #{days_of_development lines}"
end