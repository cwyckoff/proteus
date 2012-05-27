require 'spec_helper'

module Protean
  module Transformations
    describe Phone do

      describe "#process" do
        before :each do
          @shape = Field::Shape.new("phone", HashWithIndifferentAccess.new(:phone => '8009914044'))
        end

        it "formats a phone number in the format (xxx) yyy-zzzz" do
          # given
          blueprint = {"trans" => "phone", "type" => "formatted"}
          transformation = Phone.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.target.should == {"phone" => '(800) 991-4044'}
        end

        it "pulls out the area code" do
          # given
          blueprint = {"trans" => "phone", "type" => "area_code"}
          transformation = Phone.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == "800"
        end

        it "pulls out the prefix" do
          # given
          blueprint = {"trans" => "phone", "type" => "prefix"}
          transformation = Phone.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == "991"
        end

        it "pulls out the line number" do
          # given
          blueprint = {"trans" => "phone", "type" => "line_number"}
          transformation = Phone.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == "4044"
        end

        it "sets values to nil if it can't make a match" do
          # given
          shape = Field::Shape.new("phone", HashWithIndifferentAccess.new(:phone => '009914044'))
          blueprint = {"trans" => "phone", "type" => "line_number"}
          transformation = Phone.new(blueprint)

          # when
          transformation.process(shape)

          # expect
          shape.value.should == nil
        end
      end
    end
  end
end
