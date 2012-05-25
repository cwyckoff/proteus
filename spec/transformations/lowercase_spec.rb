require 'spec_helper'

module Protean
  module Transformations
    describe Lowercase do

      describe "#process" do

        let(:shape) { Field::Shape.new("last_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff")) }
        let(:blueprint) { {"trans" => "lowercase"} }
        let(:transformation) { Lowercase.new(blueprint) }
        
        it "renders field as lowercase" do
          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"last_name" => "wyckoff"}
        end

      end
    end
  end
end
