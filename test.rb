require File.expand_path(File.dirname(__FILE__) + '/lib/testrail_helper')

# create a new client
client = TestrailHelper::Client.new(username:'',password: '',url: 'https://blarg.testrail.com/')

# get a list of test cases by passing in the suite_id and section_id
cases = client.get_all_test_cases_in_section(suite_id: "729", section_id: "8")
cases = client.get_test_cases(suite_id: "10685", project_id: "34", priority_id: 6)

# filter your list down by various required fields. AND
filtered_cases_with_and = client.filter_by_fields_and(cases,priority_id: 4, created_by: 34)

# filter your list down by various required fields. OR
filtered_cases_with_or  = client.filter_by_fields_or(cases,priority_id: 4, created_by: 34)

# write list to file
write_to_file(cases,'/output/filename')

# update a test case by simply putting the test_id
update_test_case(12345,priority_id:2,type_id:1)

# results
get_test_plan("5000")
get_test_run("5001")
get_results_for_run("5001")
get_sections(34, 10685)

plan = client.create_test_plan(34, name: 'test plan')

client.add_plan_entry(plan['id'], suite_id: 10685, name: 'run name', include_all: true)

case_ids = []
cases.each do |caze|
  case_ids << caze['id']
end

client.add_plan_entry(plan['id'], suite_id: 10685, name: 'run name', include_all: false, case_ids: case_ids)

