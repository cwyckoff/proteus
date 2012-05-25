require 'spec_helper'

module Preppers
  
  describe Date do

    describe "#map" do

      before(:each) do
        @config = {
          "key" => "timestamp",
          "map" => "date",
          "format" => "%Y/%m/%d"
        }

        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :timestamp => "2011-01-25 10:00:00 CST"))
        @prepper = Date.new(@config)
      end
      
      it "formats an existing value to a specified date format" do
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target["timestamp"].should == "2011/01/25"
      end
      
      it "defaults to field name if source is not provided" do
        # given
        config = {
          "field" => "timestamp",
          "map" => "date",
          "format" => "%Y/%m/%d"
        }

        prepper = Date.new(config)
        
        # when
        prepper.prep(@proxy)

        # expect
        @proxy.target["timestamp"].should == "2011/01/25"
      end
      
      it "converts to iso8601 when the method is set to 'iso8601'" do
        # given
        @config["method"] = "iso8601"
        original_ts = Time.parse(@proxy.source['timestamp']).utc.iso8601
        prepper = Date.new(@config)
        prepper.prep(@proxy)

        # expect
        original_ts.should == @proxy.target["timestamp"]
      end

    end

  end

end
