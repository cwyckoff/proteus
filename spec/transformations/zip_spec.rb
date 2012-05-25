require 'spec_helper'

module Preppers

  describe Zip do

    describe "#prep" do

      before(:each) do
        @config = {
          "field" => "postal_code",
          "prep" => "zip",
          "target1" => "zip",
          "target2" => "plus4"
        }
        @lead = HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :postal_code => '66208-1234', :address => "123 Main St.")
        @prepper = Zip.new(@config)
        @proxy = FieldsProxy.new(@lead)
      end
      
      it "splits a zip into two and maps each part to a specified field" do
        # given
        @config["target1"] = "zip"
        @config["target2"] = "plus4"

        # when
        @prepper.prep(@proxy)
        
        # expect
        @proxy.target.should == {"zip" => '66208', "plus4" => "1234"}
      end

      it "maps zip even if there is no '-' between zip and plus4" do
        # given
        @config["target1"] = "zip"
        @config["target2"] = "plus4"
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :postal_code => '662081234', :address => "123 Main St."))

        # when
        @prepper.prep(proxy)
        
        # expect
        proxy.target.should == {"zip" => '66208', "plus4" => "1234"}
      end

      it "sets values as nil if it can't make a match" do
        # given
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :postal_code => 'a620812ab', :address => "123 Main St."))

        # when
        @prepper.prep(proxy)
        
        # expect
        proxy.target.should == {"zip" => nil, "plus4" => nil}
      end

      it "still populates zip even if the plus4 value is muddled" do
        # given
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :postal_code => '6620812ab', :address => "123 Main St."))
      end

      it "picks out just the base zip code if no plus4 is specified" do
        # given
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :postal_code => '84105', :address => "123 Main St."))

        # when
        @prepper.prep(proxy)
        
        # expect
        proxy.target.should == {"zip" => '84105', "plus4" => nil}
      end

    end
  end
end
