require_relative '../conn'
class Ingredient

	attr_reader:ingredients ,:name
  
  def initialize(name)
      @name= name
      
    end	

  def self.ingredients(id)
	 
   
   query = "SELECT name FROM ingredients where recipe_id = $1;"
   
   result = Database.db_connection do |conn|
     conn.exec_params(query,[id])
   end  
   arr = []
   result.to_a.each do|hash| 
     arr << Ingredient.new(hash["name"])
   end
   arr	  
   end

end    
