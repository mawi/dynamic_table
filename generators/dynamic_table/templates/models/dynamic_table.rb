class DynamicTable < ActiveRecord::Base

  has_many :registries

  def heads
    self.registries.map(&:fields).flatten.uniq
  end
  
  
  def search(params) 
  
    regs = []
    
    self.heads.each do |head|
      unless params[head.downcase.to_sym].blank?
        regs = self.send("find_by_#{head.downcase}", params["#{head.downcase.to_sym}"])
      end
    end
    
    
    regs = self.registries if regs.blank?
    
    if !params[:sort].blank?
      order = params[:order].blank? ? 'asc' : params[:order]
      registries = self.send("sort_by_#{params[:sort]}", {:order => order, :regs => regs})
    else
      registries = regs
    end
      
      registries

  end
  
  
  
  
  def after_initialize
    self.heads.each do |key|
    self.class.send(:define_method, "find_by_"+key.to_s.downcase) do |arg|
       Registry.find_by_sql("SELECT * FROM registries WHERE id IN (
       SELECT registry_id FROM (
       SELECT *,
        CASE data_type
          WHEN 'int' THEN value_int
          WHEN 'string' THEN value_string
          WHEN 'date' THEN value_date
          WHEN 'boolean' THEN value_boolean
          END as valor
          FROM field_values
          WHERE 
          data_name = '#{key}') data

       WHERE valor = '#{arg}' )
       
       AND dynamic_table_id = #{self.id}")                      
    end
    
    self.class.send(:define_method, "sort_by_"+key.to_s.downcase) do |params|
      
      order = params[:order]
      regs = params[:regs]
      regs = self.registries if regs.blank?
      if order == 'desc'
        regs.sort! { |a,b| b.values[key.downcase.to_sym] <=> a.values[key.downcase.to_sym] }
      else
      regs.sort! { |a,b| a.values[key.downcase.to_sym] <=> b.values[key.downcase.to_sym] }
      end
    end
  
  end
  
end

  
  
end
