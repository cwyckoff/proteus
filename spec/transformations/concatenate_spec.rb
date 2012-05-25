require 'spec_helper'

module Protean
  module Transformations
    describe Concatenate do
      describe "#process" do
        context "with no target present in the shape" do
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

        context "with multiple fields present in the shapes target" do

          it "concats first from the target fields" do
            # given
            concat_trans = {"trans" => "concatenate", "separator" => ", ", "format" => "last_name, first_name, address"}
            trans = Protean::Transformations::Concatenate.new(concat_trans)
            shape = Field::Shape.new("person", HashWithIndifferentAccess.new(:first_name => "CHRIS", :last_name => "Wy", :address => "123 Main St."))

            # when
            trans.process(shape)

            # expect
            shape.value.should == "Wy, CHRIS, 123 Main St."
            shape.key.should == "person"
          end

        end
      end
    end
  end
end
