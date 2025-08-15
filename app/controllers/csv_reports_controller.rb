class CsvReportsController < ApplicationController
  def index
    @reports = CsvReport.all
  end

  def show
    @csv_report = CsvReport.find(params[:id])
    redirect_to rails_blob_path(@csv_report.file, disposition: "attachment", filename: @csv_report.file.filename.to_s)
  end

  def create
    report_path = ProductsCsvReporter.call(Product.all)

    csv_report = CsvReport.create

    csv_report.attach_csv_report_file(report_path)

    redirect_to csv_reports_path
  end
end
