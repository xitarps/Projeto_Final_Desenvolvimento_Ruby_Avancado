class CreateProductCsvReportJob < ApplicationJob
  queue_as :default

  def perform(product_ids)
    puts "Starting csv report generation"
    puts "product ids: #{product_ids.join(', ').truncate(100)}"
    report_path = ProductsCsvReporter.call(Product.where(id: product_ids))

    csv_report = CsvReport.create

    csv_report.attach_csv_report_file(report_path)
    puts "Generated Csv Report\n"
  end
end
