class ProductsCsvReporter
  include CsvReporter

  fields :name, :price
  file_path "#{Rails.root}/tmp/"
  mode :write
  write_headers true
  headers :name, :price
  column_separator ","

  def name
    object.name.downcase
  end

  def price
    "R$#{object.price.to_f}"
  end
end
