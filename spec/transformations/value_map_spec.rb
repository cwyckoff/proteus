require 'spec_helper'

module Protean
  module Transformations
    describe ValueMap do
      describe "#process" do
        before :each do
          @blueprint = {"trans" => "value_map", "mappings" => {"January" => "1"}}
          @transformation = ValueMap.new(@blueprint)
        end

        it "maps a field to a specific value based on the original value" do
          # given
          shape = Field::Shape.new("month", HashWithIndifferentAccess.new(:month => 'January'))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "1"
        end
        it "uses the default value if no mappings match" do
          # given
          blueprint = {"trans" => "value_map", "mappings" => {"January" => "1"}, "default" => "13"}
          transformation = ValueMap.new(blueprint)
          shape = Field::Shape.new("month", HashWithIndifferentAccess.new(:month => 'March'))

          # when
          transformation.process(shape)

          # expect
          shape.value.should == "13"
        end
        it "keeps the current value if no mappings match and there is no default" do
          # given
          shape = Field::Shape.new("month", HashWithIndifferentAccess.new(:month => 'March'))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "March"
        end
      end
    end
  end
end
