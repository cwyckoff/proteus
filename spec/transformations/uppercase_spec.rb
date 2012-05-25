require 'spec_helper'

module Protean
  module Transformations
    describe Uppercase do

      describe "#process" do

        let(:shape) { Field::Shape.new("last_name", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff")) }
        let(:blueprint) { {"trans" => "uppercase"} }
        let(:transformation) { Uppercase.new(blueprint) }
        
        it "renders field as lowercase" do
          # when
          transformation.process(shape)

          # expect
          shape.target.should == {"last_name" => "WYCKOFF"}
        end

      end

    end
  end
end
