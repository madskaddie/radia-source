class ProgramScheduleController < ApplicationController
  before_filter :login_required, :except => :show
  before_filter :setup_minical
  
  helper :broadcasts  
  
  # GET /schedule
  # GET /schedule.:format
  def show
    @schedule = schedule
    respond_to do |format|
      format.html do
        @broadcasts = schedule.broadcasts_and_gaps(Time.now.utc, 1.day.from_now.utc) 
        # renders show.html.erb
      end
      format.xml do 
        except = [:id, :created_at, :updated_at]
        render :xml => @schedule.to_xml(:except => except)
      end
    end
  end
  
  # GET /schedule/edit
  def edit
    @schedule = schedule
  end
  
  # POST /schedule/load
  def load_schedule
    @schedule = schedule
    
    # dtstart = (params[:start] ? ProgramSchedule.get_datetime(params[:start]) : Time.now)
    dtend = ProgramSchedule.get_datetime(params["new_schedule"]["end"])

    j = Jobs::ScheduleDownloadAndMergeJob.new(:dtend => dtend)
    j.perform #sync
    #Delayed::Job.enqueue(j) #async

    flash[:notice] = "A job to perform this task has been scheduled"
    render :action => 'edit'
    
    #if !(@result = @schedule.load_calendar(params[:new_schedule])).nil?
    #  render :action => 'load'
    #else
    #  flash[:error] = "There were problems with the given parameters"
    #  redirect_to :action => 'edit'
    #end
  end

  # PUT /schedule
  def update
    @schedule = schedule
    if @schedule.update_originals(params[:to_create], params[:to_destroy])
      redirect_to :action => 'show'
    else
      redirect_to :action => 'edit'
    end
  end

  protected
  
  def setup_minical
    @caldate = Time.now
    @calbroadcasts = schedule.broadcasts.find_all_by_date(Time.now.year, Time.now.month)
  end

  def active_nav
    @active = 'schedule'
  end
end
