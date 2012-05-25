require 'spec_helper'

module Preppers

  describe Interpolate do
    
    describe "#prep" do

      before(:each) do
        config = {
          "format" => "[last_name] - [first_name]",
          "target" => "name",
          "prep" => "interpolate"
        }

        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(
                                                               :first_name => "Josh",
                                                               :last_name => "Fenio",
                                                               :postal_code => '85905-1234',
                                                               :state => 'NV',
                                                               :address => "1234 Main St."
                                                               )
                                 )
        @prepper = Interpolate.new(config)
      end

      it "replaces variables with values provided in the field prepping hash" do 
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target.should == { "name" => "Fenio - Josh" }
      end

      it "replaces a variable with a blank string if it's not on the lead" do
        # when
        config = {
          "format" => "[missing_key], [last_name]",
          "target" => "name",
          "prep" => "interpolate"
        }
        prepper = Interpolate.new(config)
        prepper.prep(@proxy)

        # expect
        @proxy.target.should == { "name" => ", Fenio" }
      end

    end

  end

end
