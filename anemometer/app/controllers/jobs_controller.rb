class JobsController < ApplicationController

  def index
    @jobs = Job.where( :userid => current_user.id )
    puts @jobs
  end

  # def submittedvalues
  #   puts "here"
  #   puts params[:station]
  #   puts params[:submissiontime]
  #   puts "here"
  # end

end
