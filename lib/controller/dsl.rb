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
              define_method("#{resource_method}_with_#{extension}") do
                send("#{resource_method}_without_#{extension}").tap do |obj|
                  obj.extend(extension)
                end
              end
              alias_method "#{resource_method}_without_#{extension}", resource_method
              alias_method resource_method, "#{resource_method}_with_#{extension}"
            end
          end
        end
      end
    end
  end
end
