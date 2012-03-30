DCI::ExtendingNil = Class.new StandardError

nil_meta_class = class << nil; self; end

nil_meta_class.instance_eval do
  define_method(:extend) do |m|
    message = "You attempted to extend a nil object with the module #{m}"
    raise DCI::ExtendingNil.new message
  end
end
