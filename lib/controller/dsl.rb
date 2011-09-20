module DCI
  module Controller
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def extend_resource(resource_method, *extensions)
          class_eval do
            extensions.each do |extension|
              with_method = "#{resource_method}_with_#{extension}"
              without_method = "#{resource_method}_without_#{extension}"

              define_method(with_method) do |*args|
                instance_variable_get("@#{with_method}") || send(without_method, *args).tap do |obj|
                  obj.extend(extension)
                  instance_variable_set("@#{with_method}", obj)
                end
              end
              alias_method without_method, resource_method
              alias_method resource_method, with_method
            end
          end
        end
      end
    end
  end
end
