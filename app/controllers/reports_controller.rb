class ReportsController < ApplicationController
  def index
  	@reports = if params[:keywords]
                 Report.where('name like ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end
end
