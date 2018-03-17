require 'testrail_client'
require 'json'

require File.expand_path(File.dirname(__FILE__) + '/testrail_api')

module TestrailHelper

  class Client

    def initialize(params = {})
      @client = TestRail::APIClient.new(params[:url])
      @client.user = params[:username]
      @client.password = params[:password]
      @client
    end

    def get_all_test_cases_in_section(params={})
      uri = "get_cases/#{params[:section_id]}&suite_id=#{params[:suite_id]}"
      uri = uri + "&priority_id=#{params[:priority]}" if params[:priority]
      @client.send_get(uri)
    end

    def get_test_cases(params={})
      uri = "get_cases/#{params[:project_id]}&suite_id=#{params[:project_id]}"
      uri = uri + "&suite_id=#{params[:suite_id]}" if params[:suite_id]
      uri = uri + "&section_id=#{params[:section_id]}" if params[:section_id]
      uri = uri + "&priority_id=#{params[:priority_id]}" if params[:priority_id]
      @client.send_get(uri)
    end

    def get_run_info(run_id)
      uri = "get_run/#{run_id}"
      @client.send_get(uri)
    end

    def get_tests(run_id)
      uri = "get_tests/#{run_id}"
      @client.send_get(uri)
    end

    def get_plan(plan_id)
      uri = "get_plan/#{plan_id}"
      @client.send_get(uri)
    end

    def filter_by_fields_and(list, params={})
      @master_list = list
      @temp_list = []
      h = params.map
      h.each do |par|
        puts par
        @master_list.each do |x|
          puts x
          if x.fetch(par[0].to_s) == par[1]
            @temp_list << x
          end
        end
        @master_list = @temp_list
        @temp_list = []
      end
      @master_list
    end

    def filter_by_fields_or(list, params={})
      @temp_list = list
      h = params.map
      h.each do |par|
        puts par
        @master_list.each do |x|
          puts x
          if x.fetch(par[0].to_s) == par[1]
            @temp_list << x
          end
        end
      end
      @master_list = @temp_list.uniq
      @master_list
    end

    def update_test_case(case_id, params={})
      puts "updating"
      params.merge({title:get_title(case_id)})
      puts params
      uri = "update_case/#{case_id}"
      puts @client.send_post(uri, params)
    end

    def get_all_users
      puts "getting all users"
      uri = "get_users"
      @client.send_get(uri)
    end

    def get_all_active_users
      puts "getting all active_users"
      uri = "get_users"
      users = @client.send_get(uri)
      active_users = []
      users.each do |x|
        active_users << x if x.fetch('is_active') == true
      end
      active_users
    end

    def get_user(user_id)
      puts "getting title"
      uri = "get_user/#{user_id}"
      @client.send_get(uri)
    end

    def get_user_by_email(email)
      puts "getting title"
      uri = "get_user_by_email&email=#{email}"
      @client.send_get(uri)
    end

    def get_title(case_id)
      puts "getting title"
      uri = "get_case/#{case_id}"
      @client.send_get(uri)
    end

    def write_to_file(list, filename)
      File.open(filename, "w+") do |f|
        list.each { |element| f.puts(element) }
      end
    end

    def get_test_plan(plan_id)
      uri = "get_plan/#{plan_id}"
      @client.send_get(uri)
    end


    def get_test_run(run_id)
      uri = "get_run/#{run_id}"
      @client.send_get(uri)
    end

    def get_results_for_run(run_id)
      uri = "get_results_for_run/#{run_id}"
      @client.send_get(uri)
    end

    def get_sections(project_id, suite_id)
      uri = "get_sections/#{project_id}&suite_id=#{suite_id}"
      @client.send_get(uri)
    end

    def create_test_plan(project_id, params={})
      uri = "add_plan/#{project_id}"
      @client.send_post(uri, params)
    end

    def add_plan_entry(plan_id, params={})
      uri = "add_plan_entry/#{plan_id}"
      @client.send_post(uri, params)
    end
  end
end
