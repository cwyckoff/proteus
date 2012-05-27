require 'spec_helper'

module Protean
  module Transformations
    describe State do
      describe "#process" do
        before :each do
          @blueprint = {"trans" => "state"}
          @transformation = State.new(@blueprint)
        end
        it "maps the state abbreviation to a full name" do
          # given
          shape = Field::Shape.new("state", HashWithIndifferentAccess.new(:state => "UT"))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "Utah"
        end

        it "returns the original value if it can't map it" do
          # given
          shape = Field::Shape.new("state", HashWithIndifferentAccess.new(:state => "ZZ"))

          # when
          @transformation.process(shape)

          # expect
          shape.value.should == "ZZ"
        end
      end
    end
  end
end
