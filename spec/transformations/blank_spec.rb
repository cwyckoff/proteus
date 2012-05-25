require 'spec_helper'

module Protean
  module Transformations
    describe Blank do
      describe "#process" do
        let(:blueprint) { {"trans" => "blank"} }
        let(:shape) { Field::Shape.new("source_id", HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :address => "123 Main St.")) }
        let(:transformation) { Blank.new(blueprint) }
        
        it "creates a key value pair with the value being blank" do
          # when
          transformation.process(shape)

          # expect
          shape.target["source_id"].should be_blank
        end
        
      end
    end
  end
end
