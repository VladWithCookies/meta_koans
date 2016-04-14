class Module
	def attribute(a, &block)	
		a, default = a.to_a.first if a.is_a? Hash
		var = :"@#{a}"

		define_method(:"#{a}?") { send(a) }

		define_method :"#{a}=" do |value|
			instance_variable_set(var, value)
		end

		define_method :"#{a}" do 
			if instance_variables.include? var
				instance_variable_get var
			elsif block
				instance_eval(&block)
			else
				instance_variable_set(var, default)
			end
		end

	end
end