class CsvReportsController < ApplicationController
  def index
    @reports = CsvReport.all
  end

  def show
    @csv_report = CsvReport.find(params[:id])
    redirect_to rails_blob_path(@csv_report.file, disposition: "attachment", filename: @csv_report.file.filename.to_s)
  end

  def create
    CreateProductCsvReportJob.perform_later(Product.all.pluck(:id))

    redirect_to csv_reports_path
  end
end
