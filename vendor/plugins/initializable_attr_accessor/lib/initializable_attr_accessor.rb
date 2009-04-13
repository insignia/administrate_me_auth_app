class Module
 def initializable_attr_accessor(*args)
   attr_accessor(*args)

   define_method :initialize do |*args_or_hash|
     args_or_hash = (args_or_hash.size == 1 && args_or_hash.first.is_a?(Hash)) ? args_or_hash.first : args_or_hash

     case args_or_hash
       when Hash
         args_or_hash.each do |key,value|
           send("#{key}=", value)
         end

       when Array
         args.each_index do |i|
           send("#{args[i]}=", args_or_hash[i])
         end
     end
   end
 end
end
