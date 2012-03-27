require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class DCI::TestModel; end

module DCI::TestRole
  include DCI::Role

  extended_singleton_class_eval do
    self.model_class_method
  end
end

describe DCI::Role do
  let(:instance) { DCI::TestModel.new }
  let(:other_instance) { DCI::TestModel.new }
  let(:instance_singleton_class) { class << instance; self; end }
  let(:other_instance_singleton_class) { class << other_instance; self; end }

  context "mixed into a model class" do
    describe "#extended_metaclass_eval" do
      it "invokes the block on the extended object's metaclass" do
        instance_singleton_class.should_receive(:model_class_method)
        other_instance_singleton_class.should_not_receive(:model_class_method)

        instance.extend(DCI::TestRole)
      end
    end
  end
end
