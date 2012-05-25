require 'spec_helper'

module Preppers

  describe ValueMap do
    
    describe "#prep" do 
    end

    before(:each) do 
      @config = {
        "prep" => "value_map",
        "key" => "source_id",
        "mappings" => {
          "ONE" => "one",
          "TWO" => "2",
          "THREE" => "III"
        },
        "default" => "NONE"
      }

      @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Josh", :last_name => "Fenio", :source_id => "TWO"))
      @prepper = ValueMap.new(@config)
    end

    it "maps a field to a specific value based on the original value" do
      # when
      @prepper.prep(@proxy)

      # expect
      @proxy.target.should == { "source_id" => "2" }
    end

    it "uses the default value if no mappings match" do
      # when
      proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:source_id => "FIVE"))
      @prepper.prep(proxy)
      
      # expect
      proxy.target.should == { "source_id" => "NONE" }
    end


  end

end
