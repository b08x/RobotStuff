#!/usr/bin/env ruby

require 'csv'

# provide markdown file with table of tasks.

repo_dir = ARGV[0]

Dir.chdir(File.join(repo_dir)) do

  # Read the markdown file and convert it to CSV
  table = CSV.parse(File.read("tasks.csv"), headers: true)

  # Iterate over the tasks
  table[2..3].each do |row|
    # Extract the task details
    task_id = row['Task ID'].strip
    task_description = row['Task Description'].strip
    priority = row['Priority'].strip
    status = row['Status'].strip
    area = row['Area'].strip

    # Create the issue title and body
    title = "Task #{task_id}: #{task_description}"
    body = "Priority: #{priority}\nStatus: #{status}\nArea: #{area}"


    `gh issue create --title "#{title}" --label "#{priority},#{status},#{area}" --body "#{body}"`

  end

end
