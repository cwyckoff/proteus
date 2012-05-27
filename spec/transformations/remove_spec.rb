require 'spec_helper'

module Protean
  module Transformations
    describe Remove do
      describe "#process" do
        it "removes the field if it fulfills the conditional" do
          # given
          blueprint = {"trans" => "phone", "conditional" => "blank?"}
          transformation = Remove.new(blueprint)
          shape = Field::Shape.new("address2", HashWithIndifferentAccess.new(:address2 => ''))

          # when
          transformation.process(shape)

          # expect
          shape.target.should == {}
        end
      end
    end
  end
end
