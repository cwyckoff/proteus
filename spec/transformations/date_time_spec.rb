require 'spec_helper'

module Preppers
  
  describe DateTime do

    describe "#map" do

      before(:each) do
        @config = {
          "key" => "timestamp",
          "prep" => "date_time",
          "format" => "%Y/%m/%d",
          "target" => "lead_date"
        }

        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :timestamp => "2011-01-25 10:00:00 CST"))
        @prepper = DateTime.new(@config)
      end
      
      it "formats an existing value to a specified date format" do
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target["lead_date"].should == "2011/01/25"
      end
      
      it "maps formatted date to a 'target' key" do
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target["lead_date"].should == "2011/01/25"
      end
      
      it "defaults to field name if source is not provided" do
        # given
        config = {
          "field" => "timestamp",
          "prep" => "date_time",
          "format" => "%Y/%m/%d",
          "target" => "lead_date"
        }

        prepper = DateTime.new(config)
        
        # when
        prepper.prep(@proxy)

        # expect
        @proxy.target["lead_date"].should == "2011/01/25"
      end
      
      it "maps to timezone if specified" do
        # given
        config = {
          "field" => "timestamp",
          "prep" => "date_time",
          "target" => "lead_date",
          "format" => "%Y/%m/%d %H:%M:%S %Z",
          "timezone" => "US/Pacific"
        }
        
        prepper = DateTime.new(config)
        # when
        hash = prepper.prep(@proxy)

        # expect
        @proxy.target["lead_date"].should == "2011/01/25 08:00:00 PST"
      end
      
      it "raises a MissingTimezone exception if no source timezone is supplied" do
        proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff", :timestamp => "2011-01-25 10:00:00"))
        
        lambda { @prepper.prep(proxy) }.should raise_error(Preppers::MissingTimezone)
      end

      it "converts to iso8601 when the method is set to 'iso8601'" do
        # given
        @config["method"] = "iso8601"
        original_ts = Time.parse(@proxy.source['timestamp']).utc.iso8601
        prepper = DateTime.new(@config)
        prepper.prep(@proxy)

        # expect
        original_ts.should == @proxy.target["lead_date"]
      end

    end

  end

end
