require 'spec_helper'

module Protean

  describe Transformations do

    describe ".instance_for" do

      it "returns a Transformation object" do
        # given
        trans = {"trans" => "lowercase"}
        field_name = "first_name"

        # expect
        Transformations.instance_for(field_name, trans).should be_an_instance_of(Transformations::Lowercase)
      end
      
    end
    
    describe ".to_regexp" do

      it "returns a string" do
        Transformations.to_regexp.should be_an_instance_of(String)
      end
      
      it "contains transformation names" do
        %w[lowercase uppercase truncate map concatenate zip phone].each do |t|
          Transformations.to_regexp.should match(/#{t}/)
        end
      end
      
      it "uses '|' as separator" do
        Transformations.to_regexp.should match(/\|/)
      end

    end
  end
end
