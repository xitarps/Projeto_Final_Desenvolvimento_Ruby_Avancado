class CsvReport < ApplicationRecord
  has_one_attached :file

  def attach_csv_report_file(generated_file_path)
    if generated_file_path && File.exist?(generated_file_path)
      begin
        # Open the generated file
        File.open(generated_file_path, "rb") do |file_io|
          self.file.attach(
            io: file_io,
            filename: File.basename(generated_file_path),
            content_type: "text/csv"
          )
        end

        true
      rescue => e
        Rails.logger.error "Error attaching CSV file to CsvReport ##{id}: #{e.message}"
        errors.add(:file, "could not be attached: #{e.message}")
        false
      ensure
        File.delete(generated_file_path) if File.exist?(generated_file_path)
      end
    else
      false
    end
  end
end
