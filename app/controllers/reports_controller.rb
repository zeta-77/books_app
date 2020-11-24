class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def show
    @showed_object = Report.find(params[:id])
    @comments = Comment.where(commentable_id: params[:id], commentable_type: Report.name)
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to @report, notice: t('.success')
    else
      render new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: t('.success')
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :content)
    end
end
