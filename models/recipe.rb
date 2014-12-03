require_relative '../conn'

class Recipe

	attr_reader :id, :name, :instructions, :description, :ingredients
  
    def initialize(id, name , instructions , description , ingredients = nil)
    	@id = id
    	@name = name
    	@instructions = instructions
    	@description = description
      @ingredients = ingredients
     
    end	
    
    def self.all

      query = "SELECT id, name, instructions, description FROM recipes"
  		
      result = Database.db_connection do |conn|
    	  conn.exec(query)
  		end  	
      
      arr = []

      result.to_a.each do|hash|
      	arr << Recipe.new(hash["id"], hash["name"], hash["instructions"], hash["description"])
      end
      arr
    
	end	


	def self.find(id)
    query = "SELECT id, name, instructions, description FROM recipes where id = $1;"
  		
    result = Database.db_connection do |conn|
    	conn.exec_params(query,[id])
  	end 
      
    return Recipe.new(result.to_a[0]["id"], result.to_a[0]["name"], result.to_a[0]["instructions"], result.to_a[0]["description"],Ingredient.ingredients(id))
     
  end	
    
end
