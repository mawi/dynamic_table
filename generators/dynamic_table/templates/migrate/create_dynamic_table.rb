class CreateDynamicTable < ActiveRecord::Migration
  def self.up

    create_table :dynamic_tables, :force => true do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :registries, :force => true do |t|
      t.integer :dynamic_table_id
      t.timestamps
    end
    
    create_table :field_values, :force => true do |t|
      t.string :data_type
      t.string :data_name
      t.integer  :value_int
      t.string  :value_string
      t.bool :value_boolean
      t.date :value_date
      t.integer :registry_id
      t.timestamps
    end
    
  end

  def self.down
    drop_table :field_values
    drop_table :registries
    drop_table :dynamic_tables
    
  end
end