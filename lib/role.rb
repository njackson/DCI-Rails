module DCI
  module Role
    def self.included(base)
      base.extend(ModuleMethods)
    end

    module ModuleMethods
      def extended_singleton_class_eval(&block)
        singleton_class_for(self).instance_eval do
          define_method("extended") do |obj|
            singleton_class_for(obj).instance_eval(&block)
          end
        end
      end

      private
      def singleton_class_for(obj)
        if obj.respond_to?(:singleton_class)
          obj.singleton_class
        else
          class << obj; self; end
        end
      end
    end
  end
end
