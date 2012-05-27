require 'spec_helper'

module Protean
  module Transformations
    describe Date do
      describe "#process" do
        before :each do
          @field_name = "lead_received"
          @now = Time.now.in_time_zone("MST").to_s
          @shape = Field::Shape.new(@field_name, HashWithIndifferentAccess.new({"lead_received" => @now}))
        end
        it "formats an existing value to a specified date format" do
          # given
          blueprint = {"trans" => "date", "format" => "%m-%d-%y", "timezone" => "", "type" => "format"}
          transformation = Date.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == Time.parse(@now).strftime("%m-%d-%y")
        end
        it "adheres to zone when given" do
          # given
          blueprint = {"trans" => "date", "format" => "%m-%d-%y", "timezone" => "Asia/Bangkok", "type" => "format"}
          transformation = Date.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == Time.parse(@now).in_time_zone("Asia/Bangkok").strftime("%m-%d-%y")
        end
        it "follows the iso8601 format when set" do
          # given
          blueprint = {"trans" => "date", "type" => "iso8601"}
          transformation = Date.new(blueprint)

          # when
          transformation.process(@shape)

          # expect
          @shape.value.should == Time.parse(@now).utc.iso8601
        end
        it "raise an error when the incorrect date type is used" do
          # given
          blueprint = {"trans" => "date", "type" => "bad_type"}
          transformation = Date.new(blueprint)

          # expect
          lambda { transformation.process(@shape) }.should raise_error(Protean::ProteusInvalidDateType)
        end
      end
    end
  end
end


