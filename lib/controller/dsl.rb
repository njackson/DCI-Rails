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
              alias_method :"#{resource_method}_without_#{extension}", resource_method
              define_method(resource_method) do
                send("#{resource_method}_without_#{extension}").tap do |obj|
                  extensions.each do |extension|
                    obj.extend(extension)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
