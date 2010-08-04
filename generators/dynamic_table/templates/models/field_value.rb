class FieldValue < ActiveRecord::Base
  attr_accessor :value
  belongs_to :registry


  def value=(_value)
    case self.data_type
      when 'int' then
        self.value_int = _value
      when 'string' then
        self.value_string = _value
      when 'date' then
        self.value_date = _value
      when 'boolean' then
        self.value_boolean = _value
    end
  end

  def value
    case self.data_type
      when 'int' then
        self.value_int
      when 'string' then
        self.value_string
      when 'date' then
        self.value_date
      when 'boolean' then
        self.value_boolean
    end    
  end


end
