class DashboardsController < ApplicationController
  before_action :set_dashboard, only: %i[ show edit update destroy ]

  # GET /dashboards or /dashboards.json
  def index
   month_start = Time.now.at_beginning_of_month
   begin_start_month = month_start.strftime("%Y-%m-%d")
   month_end = Time.now.at_end_of_month
   end_of_month = month_end.strftime("%Y-%m-%d")
   @user_single_chart = EmployeeTimesheet.select("user_id,project_name,time_sheet_date,sum(spend_of_time)").where("time_sheet_date between ? and  ?",begin_start_month, end_of_month).group(:project_name,:time_sheet_date,:user_id).sum(:spend_of_time)
   # @emp_sheet = EmployeeTimesheet.select("project_name,time_sheet_date,sum(spend_of_time)").where("user_id=? and time_sheet_date=?",current_user.id,"2021-04-13").group(:project_name,:time_sheet_date).sum(:spend_of_time)
   @all_user_chart = EmployeeTimesheet.select("project_name,time_sheet_date,sum(spend_of_time)").where("user_id=?",current_user.id).group(:project_name,:time_sheet_date).sum(:spend_of_time)

  end

  # GET /dashboards/1 or /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards or /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: "Dashboard was successfully created." }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1 or /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: "Dashboard was successfully updated." }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1 or /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: "Dashboard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dashboard_params
      params.fetch(:dashboard, {})
    end
end
