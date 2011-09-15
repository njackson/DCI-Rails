require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class DCI::TestController
  include DCI::Controller::DSL
  attr_accessor :resource
end

module TestExtension1
  def extended_with_TestExtension1; true; end
end
module TestExtension2
  def extended_with_TestExtension2; true; end
end
module TestExtension3
  def extended_with_TestExtension3; true; end
end

describe "DCI::Controller::DSL" do
  context "mixed into a controller class" do
    describe "#extend_resource" do
      let(:controller) { DCI::TestController.new }
      let(:resource) { Object.new }

      it "extends the resource method with the provided module extensions" do
        controller.resource = resource
        (class << controller; self; end).instance_eval do
          extend_resource :resource, TestExtension1, TestExtension2, TestExtension3
        end

        resource.should_not respond_to(:extended_with_TestExtension1)
        controller.resource.should respond_to(:extended_with_TestExtension1)
        controller.resource.should respond_to(:extended_with_TestExtension2)
        controller.resource.should respond_to(:extended_with_TestExtension3)
      end
    end
  end
end
