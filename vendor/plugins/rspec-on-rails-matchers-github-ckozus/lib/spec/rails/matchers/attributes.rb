module Spec
  module Rails
    module Matchers
      
      def allow_mass_assignment_of(*attributes)
        AllowMassAssignmentOf.new(attributes)
      end

      def deny_mass_assignment_of(*attributes)
        DenyMassAssignmentOf.new(attributes)
      end
      
      class MassAssignmentOf
        def initialize(attributes)
          attributes = [attributes] unless attributes.is_a?(Array)
          @expected = attributes.map { |a| a.to_s }
        end
        
        protected
        
        def calculate_protected_and_accesible(target)
          @accesible = []
          @protected = []

          @expected.each do |attribute|
            instance = target.new(attribute => 'kind_of_matcher_parameter')
          
            if instance.send(attribute) == 'kind_of_matcher_parameter'
              @accesible << attribute
            else
              @protected << attribute
            end
          end
        end
      end

      class AllowMassAssignmentOf < MassAssignmentOf
        def matches?(target)
          calculate_protected_and_accesible(target)
          
          @failed_attributes = @expected - @accesible
          @failed_attributes.blank?
        end
        
        def description
          "allow mass assignment of #{@expected.join(', ')}"
        end
        
        def failure_message
          "expected #{@failed_attributes.join(', ')} to be accessible"
        end
        
        def negative_failure_message
          "expected #{@failed_attributes.join(', ')} to not be accessible"
        end
      end
      
      class DenyMassAssignmentOf < MassAssignmentOf
        def matches?(target)
          calculate_protected_and_accesible(target)
          
          @failed_attributes = @expected - @protected
          @failed_attributes.blank?
        end
        
        def description
          "deny mass assignment of #{@expected.join(', ')}"
        end
        
        def failure_message
          "expected #{@failed_attributes.join(', ')} to be protected"
        end
        
        def negative_failure_message
          "expected #{@failed_attributes.join(', ')} to not be protected"
        end
      end
      
    end
  end
end