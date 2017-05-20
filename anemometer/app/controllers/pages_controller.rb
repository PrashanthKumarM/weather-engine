require 'net/http'
require 'json'
require 'redis'

class PagesController < ApplicationController

  before_filter :require_current_user

  def index
    @station_list = YAML.load(File.read("config/station.yml"))
    @submittedstation = params[:station]
    @temp = params[:submissiontime]
    @rediskey = params[:rediskey]
    @redisvalue = $redis.smembers(@rediskey)
    unless @temp.nil? || @temp == 0
      @temp = @temp.to_time
      puts @temp
      # @submittedtime = @temp.strftime('%m/%d/%Y %H:%M %p') 
      # puts   @submittedtime.Time.zone_offset('EST') 
    end
  end

  def form_url
    @current_request_key = "request:"+current_user.id.to_s+":"+Time.new.utc.to_s
    add_redis_keys
    add_job_details
    submissiondatetime = params[:start][:date]
    puts submissiondatetime
    puts params[:stations]
    puts current_user.id
    puts @current_request_key
    j = Job.new({userid: current_user.id, station: params[:stations], submissiontime: Date.strptime(submissiondatetime, '%m/%d/%Y %I:%M %p').to_time, rediskey: @current_request_key})
    j.save
    @data_results = call_data_ingestor
    if @data_results.is_a?(Net::HTTPSuccess)
      flash[:success] = "Data ingested successfully!!"
    else
      flash[:failure] = "Unable to get a Data URL"
      redirect_to root_path
    end
  end

  def view_submissions
    client = JOB.find(userid , current_user.id)
    #@joblist = JOBS.select('userid, station', conditions: {:userid => current_user.id})
  end  



  def test
    redirect_to :test
  end

  private

  def require_current_user
    redirect_to sign_in_path if current_user.nil?
  end

  def add_redis_keys
    $redis.sadd("weather_machine",@current_request_key)
    $redis.sadd(@current_request_key, params[:stations])
    $redis.sadd(@current_request_key, params[:start][:date])
    $redis.sadd(@current_request_key, "Sent to Data Ingestor")
  end

  def add_job_details

  end

  def call_data_ingestor
    uri = URI(RAIN_GAUGE[Rails.env])
    uri.query = URI.encode_www_form(:stations => params[:stations], :date => params[:start][:date], :redis_key => @current_request_key)
    Net::HTTP.get_response(uri)
  end

end