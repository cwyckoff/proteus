require 'spec_helper'

module Protean
  module Transformations
    describe Interpolate do
      describe "#process" do
        before :each do
          @blueprint = {"trans" => "interpolate", "format" => "[first_name] [last_name]"}
          @transformation = Interpolate.new(@blueprint)
        end

        it "interploates fields according to the format" do
          # given
          shape = Field::Shape.new("name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff"))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "Chris Wyckoff"
          shape.key.should == "name"
        end

        it "replaces a variable with a blank string if it's not on the lead" do
          # given
          shape = Field::Shape.new("name", HashWithIndifferentAccess.new(:first_name => "Chris"))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "Chris "
        end
      end
    end
  end
end
