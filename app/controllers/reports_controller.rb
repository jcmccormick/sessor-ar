class ReportsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  	@reports = if params[:keywords]
                 Report.where('name like ?',"%#{params[:keywords]}%")
               else
                 Report.all.each
               end
  end

  def show
  	@report = Report.find(params[:id])
  end

  def create
    @report = Report.new(params.require(:report).permit(:name,:submission))
    @report.save
    render 'show', status: 201
  end

  def update
    report = Report.find(params[:id])
    report.update_attributes(params.require(:report).permit(:name,:submission))
    head :no_content
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy
    head :no_content
  end
end
