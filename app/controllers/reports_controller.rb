class ReportsController < ApplicationController
  def index
  	@reports = if params[:keywords]
                 Report.where('name like ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end

  def show
  	@report = Report.find(params[:id]) or not_found
  end
end
