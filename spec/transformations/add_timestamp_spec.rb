require 'spec_helper'

module Protean
  module Transformations
    describe AddTimestamp do
      describe "#process" do
        before :each do
          @field_name = "lead_received"
          @blueprint = {"trans" => "add_timestamp"}
          @shape = Field::Shape.new(@field_name, HashWithIndifferentAccess.new({}))
          @transformation = AddTimestamp.new(@blueprint)
          Time.zone = "US/Central"
          @current_time = Time.now.in_time_zone
          Time.zone.stub!(:now).and_return(@current_time)
        end

        it "renders field as new timestamp" do
          # when
          @transformation.process(@shape)

          # expect
          @shape.value.should == @current_time.strftime("%Y-%m-%d %H:%M:%S %Z")
          @shape.key.should == @field_name
        end

        it "uses CST (or CDT)" do
          # when
          @transformation.process(@shape)

          # expect
          # this is needed due to daylight savings time on local machines
          Time.zone.parse(@shape.value).zone.should =~ /C(D|S)T/
        end
      end
    end
  end
end

