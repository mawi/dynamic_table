class Registry < ActiveRecord::Base
  
  has_many :field_values
  belongs_to :dynamic_table

  
  def values
    values = {}
    self.field_values.each do |r|
      values[r.data_name.downcase.to_sym] = r.value 
    end
    values
  end
  
  def fields
    fields = []
    self.field_values.each do |r|
      fields << r.data_name
    end
    fields
  end

  
  def after_initialize
    self.values.keys.each do |key|
      self.class.send(:define_method, key.to_s.downcase) do
        values[key]
      end
      
    end
  end
  
  
  
end