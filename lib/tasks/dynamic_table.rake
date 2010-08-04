namespace :db do
  desc 'Create an example of dynamic_table'
  task :dynamic_populate => :environment do
  
  citys = ["A Coruña", "Alicante", "Almeria", "Amsterdam", "Asturias", "Barcelona", "Bilbao", "Bolonia", "Bristol", "Sevilla", "Malaga"]
  companies = ["Air Berlin", "Air Europa", "Air France", "Air Nostrum", "Iberia", "Brussel Airlines", "Ryanair", "Spanair", "Tap Portugal", "Vueling"]
  hours = ["8:00", "10:00", "12:00", "13:30", "16:00", "19:45", "20:00", "22:15", "23:00", "4:00"]
  state = ["En vuelo", "Retrasado", "Cancelado", "Embarque"]
  
  DynamicTable.delete_all
  Registry.delete_all
  FieldValue.delete_all
  
  c = DynamicTable.create(:name => "Vuelos")
  
  20.times do
    
    
    r = c.registries.create 
    
    
    
    r.field_values.create(:data_type => 'string', :data_name => "Vuelo", :value => generate_reference)
    r.field_values.create(:data_type => 'string', :data_name => "Hora", :value => hours.rand)
    r.field_values.create(:data_type => 'string', :data_name => "Compañia", :value => companies.rand)
    r.field_values.create(:data_type => 'int', :data_name => "Puerta", :value => rand(10)+1)
    r.field_values.create(:data_type => 'string', :data_name => "Estado", :value => state.rand)
    r.field_values.create(:data_type => 'string', :data_name => "Origen", :value => citys.rand)
    r.field_values.create(:data_type => 'string', :data_name => "Destino", :value => citys.rand)

  
  end   
  
  
  
  end
  
  def generate_reference
    alphanumerics = ('a'..'z').sort_by{rand}[0..1] +  ('0'..'9').sort_by{rand}[0..4]  
    token = alphanumerics.to_s.upcase
  end
  
end