# require "csv"
# require "fileutils"

module CsvReporter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    attr_reader :object

    def initialize(instance)
      @object = instance
    end

    def method_missing(target_method, *args, &block)
      object.send(target_method)
    end
  end

  module ClassMethods
    MODE = {
      append: "a",
      write: "w",
      read: "r+"
    }


    MODE.default = "a"

    def fields(*fields_array)
      fields_array = class_variable_get("@@fields") if class_variable_defined?("@@fields")

      class_variable_set("@@fields", fields_array)
    end

    def file_path(folder)
      folder = class_variable_get("@@folder") if class_variable_defined?("@@folder")

      class_variable_set("@@folder", folder)
    end

    def mode(persistance_mode)
      persistance_mode = class_variable_get("@@persistance_mode") if class_variable_defined?("@@persistance_mode")

      class_variable_set("@@persistance_mode", persistance_mode)
    end

    def write_headers(is_writing_headers)
      is_writing_headers = class_variable_get("@@is_writing_headers") if class_variable_defined?("@@is_writing_headers")

      class_variable_set("@@is_writing_headers", is_writing_headers)
    end

    def headers(*header_fields)
      header_fields = class_variable_get("@@header_fields") if class_variable_defined?("@@header_fields")

      class_variable_set("@@header_fields", header_fields)
    end

    def column_separator(separator)
      separator = class_variable_get("@@separator") if class_variable_defined?("@@separator")

      class_variable_set("@@separator", separator)
    end

    def get_configs
      target_folder = class_variable_get("@@folder").gsub(/\/[^\/]+\.csv/, "/") if class_variable_defined?("@@folder")
      target_mode = class_variable_get("@@persistance_mode") if class_variable_defined?("@@persistance_mode")
      target_fields = class_variable_get("@@fields") if class_variable_defined?("@@fields")
      target_headers = class_variable_get("@@header_fields") if class_variable_defined?("@@header_fields")
      write_target_headers = class_variable_get("@@is_writing_headers") if class_variable_defined?("@@is_writing_headers")
      target_separator = class_variable_get("@@separator") if class_variable_defined?("@@separator")

      [ target_folder, target_mode, target_fields, target_headers, write_target_headers, target_separator ]
    end

    def call(instances_array, opts: {})
      target_folder, target_mode, target_fields, target_headers, write_target_headers, target_separator = get_configs

      return if target_fields.nil? || target_fields.empty?

      header_options = { write_headers: false, headers: []}
      header_options[:write_headers] = (write_target_headers ? write_target_headers : false)
      header_options[:headers] = (header_options[:write_headers] ? (target_headers || target_fields) : [])

      file_name = opts.dig(:file_name)
      file_name ||= Time.now.strftime("%Y%m%d%H%M%s_#{SecureRandom.hex(4)}")+".csv"
      path_part = target_folder || "./"
      full_path = path_part << file_name

      CSV.open(full_path, MODE[target_mode&.to_sym], col_sep: (target_separator || ","), **header_options) do |csv|
        instances_array.each do |instance|
          csv << target_fields.map do |field|
            self.new(instance).send(field)
          end
        end
      end

      full_path.to_s
    end
  end
end
