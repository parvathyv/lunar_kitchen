require_relative '../conn'
class Recipe

	attr_reader :id, :name, :instructions, :description, :ingredients
  
    def initialize(id, name, instructions, description, ingredients = nil)
    	@id = id
    	@name = name
    	@instructions = instructions
    	@description = description
      @ingredients = ingredients
    end	
    
    def self.all

      query = "SELECT id, name, instructions, description FROM recipes"
  		result = db_connection do |conn|
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
  		result1 = db_connection do |conn|
    	 conn.exec_params(query,[id])
  		end 
     
      return Recipe.new(result1.to_a.first["id"], result1.to_a.first["name"], result1.to_a.first["instructions"], 
        result1.to_a.first["description"],Ingredient.ingredients(id))

  end	
      
    def self.each


    end	

    

end
