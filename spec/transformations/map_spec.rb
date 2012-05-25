require 'spec_helper'

module Protean
  module Transformations
    describe Map do

      describe "#process" do
        let(:blueprint) { {"trans" => "map", "target" => "fname"} }
        let(:shape) { Field::Shape.new("first_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :address => "123 Main St.")) }
        let(:transformation) { Map.new(blueprint) }
        
        it "maps a field to a target" do
          # when
          transformation.process(shape)

          # expect
          shape.target["fname"].should == "Chris"
        end
        
        it "removes the old field from the source" do
          # when
          transformation.process(shape)

          # expect
          shape.target.should_not have_key("first_name")
        end
      end
    end
  end
end
