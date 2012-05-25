require 'spec_helper'

module Protean
  module Transformations
    describe Prepop do
      describe "#process" do
        let(:blueprint) { {"value" => "ABC123", "trans" => "prepop"} }
        let(:shape) { Field::Shape.new("source_id", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :address => "123 Main St.")) }
        let(:transformation) { Prepop.new(blueprint) }
        
        it "create a new field with prepopulated value" do
          # when
          transformation.process(shape)

          # expect
          shape.target["source_id"].should == "ABC123"
        end
        
      end

    end
  end
end
