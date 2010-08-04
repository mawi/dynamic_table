class DynamicTableGenerator < Rails::Generator::Base

  def manifest
    
    record do |m|
    
    m.file "models/dynamic_table.rb", "app/models/dynamic_table.rb"
    m.file "models/registry.rb", "app/models/registry.rb"
    m.file "models/field_value.rb", "app/models/field_value.rb"
    
    m.migration_template "migrate/create_dynamic_table.rb", "db/migrate"
    
    end

end

  def file_name
    "create_dynamic_table"
  end
  
end