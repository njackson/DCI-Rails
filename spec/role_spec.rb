require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class DCI::TestModel
  class << self
    attr_accessor :model_class_method_invoked
    def model_class_method
      self.model_class_method_invoked = true
    end
  end
end

module DCI::TestRole
  include DCI::Role

  extended_metaclass_eval do
    self.model_class_method
  end
end

describe DCI::Role do
  let(:instance) { DCI::TestModel.new }

  context "mixed into a model class" do
    describe "#extended_metaclass_eval" do
      it "invokes the block on the extended object's metaclass" do
        instance.extend(DCI::TestRole)

        (class << instance; self; end).model_class_method_invoked.should be_true
        DCI::TestModel.model_class_method_invoked.should be_false
      end
    end
  end
end
