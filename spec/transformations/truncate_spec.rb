require 'spec_helper'

module Protean
  module Transformations

    describe Truncate do

      describe "#process" do

        let(:blueprint) { {"limit" => 5, "trans" => "truncate"} }
        let(:shape) { Field::Shape.new("last_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff")) }
        let(:transformation) { Truncate.new(blueprint) }

        it "truncates field to a specified limit" do
          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"last_name" => "Wycko"}
        end

        it "returns field as is if characters do not exceed specified limit" do
          # given
          shape = Field::Shape.new("last_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyck"))

          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"last_name" => "Wyck"}
        end

        it "returns empty string if value is nil" do
          # given
          shape = Field::Shape.new("last_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => nil))

          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"last_name" => ""}
        end
      end
    end
  end
end
