require 'spec_helper'

module Protean
  module Transformations
    describe Prepop do
      describe "#process" do
        let(:blueprint) { {"value" => "ABC123", "trans" => "prepop"} }
        let(:shape) { Field::Shape.new("source_id", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :address => "123 Main St.")) }
        let(:transformation) { Prepop.new(blueprint) }

        it "creates a new field with prepopulated value" do
          # when
          transformation.process(shape)

          # expect
          shape.value.should == "ABC123"
          shape.key.should == "source_id"
        end
      end
    end
  end
end
