require 'spec_helper'

module Protean
  module Transformations
    describe Concatenate do

      describe "#process" do
        let(:blueprint) { {"trans" => "concatenate", "separator" => ", ", "format" => "last_name, first_name"} }
        let(:shape) { Field::Shape.new("name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :address => "123 Main St.")) }
        let(:transformation) { Concatenate.new(blueprint) }
        
        it "concatenates two or more fields using a specified separator" do
          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"name" => "Wyckoff, Chris"}
        end

        it "uses ',' by default if a separator is not specified" do
          # given
          transformation = Concatenate.new({"trans" => "concatenate", "format" => "last_name, first_name"})

          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"name" => "Wyckoff, Chris"}
        end

      end
    end
  end
end
