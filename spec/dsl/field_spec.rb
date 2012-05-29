require 'spec_helper'

Fie = Protean::DSL::FieldDSL

module Protean
  module DSL
    describe Field do
      describe "#new" do
        it "creates a wrapper around a field with given name" do
          # when
          field = Fie.new("first_name")

          # expect
          field.subject.class.should == Protean::Field
          field.name.should == "first_name"
        end
      end
      describe "#with" do
        it "creates a transformation inside the field and returns itself" do
          # given
          field = Fie.new("postal_code")
          field.transformations.should == []

          # when
          returned = field.with(:zip_type, "prefix")

          # expect
          returned.should == field
          returned.transformations.count.should == 1
          returned.transformations.first.class.should == Protean::Transformations::Zip
        end
        it "pulls from the first argument the transformation type and cardinality" do
          # given
          field = Fie.new("postal_code")

          # when
          field.with(:zip_type, "prefix")

          # expect
          field.transformations.first.blueprint["type"].should == "prefix"
        end
        it "handles multiple arguments to the transformation" do
          # given
          field = Fie.new("date")

          # when
          returned = field.with(:date_format_and_timezone, "%Y-%m-%d", "MST")

          # expect
          trans = returned.transformations.first
          trans.blueprint["format"].should == "%Y-%m-%d"
          trans.blueprint["timezone"].should == "MST"
        end
      end
      describe "#and" do
        it "creates and adds a transformtion to the field" do
          # given
          field = Fie.new("date")
          field.with(:date_format_and_timezone, "%Y-%m-%d", "MST")
          field.transformations.count.should == 1

          # when
          field.and(:map_target, "DOB")

          # expect
          field.transformations.count.should == 2
        end
      end
      describe "#considering" do
        xit "changes context to modifying the sub fields" do
          # given
          field = Fie.new("date")
          field.with(:date_format_and_timezone, "%Y-%m-%d", "MST")
          field.subs.count.should == 0

          # when
          sub_field = field.considering._zip_code

          # expect
          field.subs.count.should == 1
          field.subs.first.should == sub_field
          sub_field.class.should == Protean::DSL::FieldDSL
         end
        xit "can add additional sub fields" do
          # given
          field = Fie.new("date")
          field.considering._zip_code
          field.subs.count.should == 1

          # when
          field.considering._other

          # expect
          field.subs.count.should == 2
        end
        xit "will return an existing sub field" do

        end
      end
      describe "#to_hash" do
        xit "returns a valid hash for the Protean::Field class" do
          # given
          field = Fie.new("date")
          field.with(:date_format_and_timezone, "%Y-%m-%d", "MST")
          field.and(:map_target, "DOB")
          field.considering.zip_code.with(:map_target, :date)

          # when
          hsh = field.to_hash

          # expect
          hsh.should == {"date" => [{"trans" => "date", "format" => "%Y-%m-%d", "timezone" => "MST"},
              {"trans" => "map", "target" => "DOB"},
              {"subs_trans" => {"zip_code" => [{"trans" => "map", "target" => "date"}]}}
            ]}
        end
      end
    end
  end
end
