class SymbolTable
	def initialize
		@class_table = Hash.new
		@sub_table = Hash.new
	end
	
	def start_subroutine
		@sub_table = Hash.new
	end
	
	def define(name, ident_type, ident_kind)
		var_index = var_count(ident_kind)
		if(ident_kind.eql?("static") or ident_kind.eql?("this"))
			@class_table[name] = Hash["kind" => ident_kind, "type" => ident_type, "index" => var_index]
		else
			@sub_table[name] = Hash["kind" => ident_kind, "type" => ident_type, "index" => var_index]
		end
	end
	
	def var_count(kind)
		count = 0
		if(kind.eql?("static") or kind.eql?("this"))
			@class_table.keys.each do |key|
				if @class_table[key]["kind"] == kind
					count += 1
				end
			end
		else
			@sub_table.keys.each do |key|
				if @sub_table[key]["kind"] == kind
					count += 1
				end
			end
		end
		return count
	end
	
	def kind_of(name)
		if @sub_table.has_key?("name")
			return @sub_table[name]["kind"]
		elsif @class_table.has_key?("name")
			return @class_table[name]["kind"]
		end	
	end
	
	def type_of(name)
		if @sub_table.has_key?("name")
			return @sub_table[name]["type"]
		elsif @class_table.has_key?("name")
			return @class_table[name]["type"]
		end
	end
	
	def index_of(name)
		if @sub_table.has_key?("name")
			return @sub_table[name]["index"]
		elsif @class_table.has_key?("name")
			return @class_table[name]["index"]
		end
	end
	
	def has?(name)
		if @sub_table.has_key?("name")
			return true
		elsif @class_table.has_key?("name")
			return true
		else
			return false;
		end
	end

end