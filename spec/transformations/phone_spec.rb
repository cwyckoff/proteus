require 'spec_helper'

module Protean
  module Transformations
    describe Phone do

      describe "#process" do
        let(:blueprint) { {"trans" => "phone", "type" => "bracket"} }
        let(:shape) { Field::Shape.new("phone", HashWithIndifferentAccess.new(:phone => '8009914044')) }
        let(:transformation) { Phone.new(blueprint) }
        
        context "Bracketed phone" do

          it "formats a phone number in the format (xxx) yyy-zzzz" do
            # when
            transformation.process(shape)

            # expect
            shape.target.should == {"phone" => '(800) 991-4044'}
          end

        end

        context "splitting phone into two fields" do

          let(:blueprint) { {"trans" => "phone", "type" => "split", "target1" => "area_code", "target2" => "phone"} }
          
          it "splits a phone number into two and maps each part to a specified field" do
            # when
            transformation.process(shape)

            # expect
            shape.target.should == {"area_code" => '800', "phone" => "9914044"}
          end

          it "sets values to nil if it can't make a match" do
            # given an 8 digit phone number
            shape = Field::Shape.new("phone_number", HashWithIndifferentAccess.new(:phone => '80099140'))

            # when
            transformation.process(shape)
            
            # expect
            shape.target.should == {"area_code"=>nil, "phone"=>nil}
          end

        end

        context "splitting phone into three fields" do

          let(:blueprint) { {"trans" => "phone", "type" => "triple", "target1" => "area_code", "target2" => "prefix", "target3" => "last4"} }

          it "splits a phone number into three parts and maps each part to a specified field" do
            # when
            transformation.process(shape)

            # expect
            shape.target.should == {"area_code" => '800', "prefix" => "991", "last4" => "4044"}
          end

          it "sets values to nil if it can't make a match" do
            # given
            shape = Field::Shape.new("phone", HashWithIndifferentAccess.new(:phone => '80099140'))

            # when
            transformation.process(shape)

            # expect
            shape.target.should == {"area_code"=>nil, "prefix"=>nil, "last4"=>nil}
          end

        end
      end
    end
  end
end
