require 'spec_helper'

module Preppers

  describe AddTimestamp do

    describe "#prep" do

      before(:each) do
        config = {
          "field" => "lead_date",
          "prep" => "add_timestamp"
        }

        @proxy = FieldsProxy.new(HashWithIndifferentAccess.new(:first_name => "Chris", :last_name => "Wyckoff"))
        Time.zone = "US/Central"
        @time = Time.zone.now
        Time.zone.stub!(:now).and_return(@time)
        @prepper = AddTimestamp.new(config)
      end
      
      it "adds a timestamp to target key" do
        # when
        @prepper.prep(@proxy)

        # expect
        @proxy.target.should == {"lead_date" => @time.strftime("%Y-%m-%d %H:%M:%S %Z")}
      end

      it "defaults to field name if target is not specified" do
        # given
        config = {
          "field" => "lead_date",
          "prep" => "add_timestamp"
        }
        prepper = AddTimestamp.new(config)
        
        # when
        prepper.prep(@proxy)

        # expect
        @proxy.target.should == {"lead_date" => @time.strftime("%Y-%m-%d %H:%M:%S %Z")}
      end
      
      it "timestamp should be CST (or CDT)" do
        # when
        @prepper.prep(@proxy)

        # expect
        Time.zone.parse(@proxy.target["lead_date"]).zone.should =~ /C(D|S)T/ # this is needed due to daylight savings time on local machines
      end

    end

  end

end
