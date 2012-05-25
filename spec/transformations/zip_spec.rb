require 'spec_helper'

module Protean
  module Transformations
    describe Zip do

      describe "#process" do
        let(:shape) { Field::Shape.new("postal_code", HashWithIndifferentAccess.new(:postal_code => "84074-4567")) }

        it "provides the zip base when field is set to base" do
          # given
          blueprint = {"trans" => "zip", "field" => "base"}
          transformation = Zip.new(blueprint)

          # when
          transformation.process(shape)

          # expect
          shape.target["postal_code"].should == "84074"
        end

        it "provides the zip base when field is set to base" do
          # given
          blueprint = {"trans" => "zip", "field" => "plus4"}
          transformation = Zip.new(blueprint)

          # when
          transformation.process(shape)

          # expect
          shape.target["postal_code"].should == "4567"
        end
      end
    end
  end
end

