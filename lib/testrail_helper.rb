require 'testrail'
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
      puts @client.send_post(uri,params)
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
  end
end
