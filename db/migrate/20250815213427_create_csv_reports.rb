class CreateCsvReports < ActiveRecord::Migration[8.0]
  def change
    create_table :csv_reports do |t|
      t.timestamps
    end
  end
end
