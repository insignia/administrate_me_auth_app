module Spec
  module Rails
    module Matchers
      def validate_presence_of(attribute)
        return simple_matcher("model to validate the presence of #{attribute}") do |model|
          model.send("#{attribute}=", nil)
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_numericality_of(attribute)
        return simple_matcher("model to validate the numericality of #{attribute}") do |model|
          model.send("#{attribute}=", 'foo')
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_length_of(attribute, options)
        if options.has_key? :within
          min = options[:within].first
          max = options[:within].last
        elsif options.has_key? :is
          min = options[:is]
          max = min
        elsif options.has_key? :minimum
          min = options[:minimum]
        elsif options.has_key? :maximum
          max = options[:maximum]
        end
        
        return simple_matcher("model to validate the length of #{attribute} within #{min || 0} and #{max || 'Infinity'}") do |model|
          status = true
          
          # First check there are no errors at limits of allowed range
          if !min.nil? && min >= 1
            model.send "#{attribute}=", 'a' * min
            status = false unless model.valid?
          end
          
          if !max.nil?
            model.send "#{attribute}=", 'a' * max
            status = false unless model.valid?
          end
          
          # Now check there are errors just off each end of range
          if !min.nil? && min >= 1
            model.send "#{attribute}=", 'a' * (min - 1)
            model.valid? # force validation
            status = false unless model.errors.invalid?(attribute)
          end
          
          if !max.nil?
            model.send "#{attribute}=", 'a' * (max + 1)
            model.valid? # force validation
            status = false unless model.errors.invalid?(attribute)
          end
          status
        end
      end

      def validate_uniqueness_of(attribute)
        return simple_matcher("model to validate the uniqueness of #{attribute}") do |model|
          model.class.stub!(:with_exclusive_scope).and_return([model])
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_confirmation_of(attribute)
        return simple_matcher("model to validate the confirmation of #{attribute}") do |model|
          model.send("#{attribute}_confirmation=", 'asdf')
          !model.valid? && model.errors.invalid?(attribute)
        end
      end

      def validate_inclusion_of(attribute, options)
        enumerable = options[:in]
        return simple_matcher("model to validate the inclusion of #{attribute} on list #{enumerable.inspect}") do |model|
          enumerable.stub!(:include?).and_return(false, true)
          model.send("#{attribute}=", 'something_not_included')
          model.valid?
          matching = model.errors.invalid?(attribute)
          model.send("#{attribute}=", 'something_included')
          model.valid?
          matching = matching && !model.errors.invalid?(attribute)
          matching
        end
      end
    end
  end
end