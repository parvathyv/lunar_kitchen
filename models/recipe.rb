require_relative '../conn'
class Recipe

	attr_reader :id, :name, :instructions, :description, :ingredients
  
    def initialize(id = nil, name = nil, instructions = nil, description = nil, ingredients = nil)
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
  		result = db_connection do |conn|
    	 conn.exec_params(query,[id])
  		end 
      
      if result.to_a.empty?
        return Recipe.new(nil, nil, "This recipe doesn't have any instructions.", "This recipe doesn't have a description.",nil)
        else

       return Recipe.new(result.to_a.first["id"], result.to_a.first["name"], result.to_a.first["instructions"], result.to_a.first["description"],Ingredient.ingredients(id))
     end 
  end	
      
    def self.each


    end	

    

end
