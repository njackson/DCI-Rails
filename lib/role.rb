module DCI
  module Role
    def self.included(base)
      base.extend(ModuleMethods)
    end

    module ModuleMethods
      def extended_metaclass_eval(&block)
        (class << self; self; end).instance_eval do
          define_method("extended") do |obj|
            (class << obj; self; end).instance_eval(&block)
          end
        end
      end
    end
  end
end
