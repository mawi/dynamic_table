class CreateDynamicTable < ActiveRecord::Migration
  def self.up

    create_table :dynamic_tables, :force => true do |t|
      t.name :string
      t.timestamps
    end
    
    create_table :registries, :force => true do |t|
      t.dynamic_table_id :integer
      t.timestamps
    end
    
    create_table :field_values, :force => true do |t|
      t.data_type :string
      t.data_name :string
      t.value_int :int
      t.value_string :string
      t.value_boolean :bool
      t.value_date :date
      t.registry_id :integer
      t.timestamps
    end
    
  end

  def self.down
    drop_table :field_values
    drop_table :registries
    drop_table :dynamic_tables
    
  end
end