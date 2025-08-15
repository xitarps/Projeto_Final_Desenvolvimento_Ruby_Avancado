class CsvFileCollection
  include Enumerable

  def initialize(items)
    @items = items.map do |item|
      item.attributes.deep_symbolize_keys.merge({
        file_name: item.file.filename.to_s
      })
    end
  end

  def each
    @items.each { |item| yield item }
  end
end
