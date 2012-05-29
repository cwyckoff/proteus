require 'spec_helper'

Prot = Protean::DSL::ProteusDSL

module Protean
  module DSL
    describe Proteus do
      describe "#new" do
        it "wraps a proteus object" do
          # given
          dsl = Prot.new

          # when
          proteus = dsl.subject

          # given
          proteus.class.should == Proteus
        end
      end
      describe "#method_missing" do
        it "matches any method to an input field and returns a wrapper to that field" do
          # given
          dsl = Prot.new

          # when
          field = dsl._first_name

          # expect
          dsl.subject.class.should == Proteus
          dsl.fields.count.should == 1
          field.class.should == Protean::DSL::FieldDSL
          field.name.should == "first_name"
        end
        it "add an entry to the protean source when passed an argument" do
          # given
          dsl = Prot.new

          # when
          dsl._first_name("George")

          # expect
          dsl.source.should == {"first_name" => "George"}
        end
        it "should return a previous field wrapper if already created" do
          # given
          dsl = Prot.new
          created_field = dsl._first_name
          dsl.fields.count.should == 1

          # when
          existing_field = dsl._first_name

          # expect
          dsl.fields.count.should == 1
          existing_field.should == created_field
        end
      end
      describe "#process" do
        xit "applies the source hash to the fields/transformations" do
          # given
          dsl = Prot.new
          dsl._full_name.with(:interpolate_format, "[first_name] [last_name]").considering._first_name("George").with(:truncate_limit, 5).and(:uppercase)
          dsl._full_name.considering._last_name("South").with(:lowercase)

          # when
          result = dsl.process

          # expect
          result.should == {"full_name" => "GEO south"}
        end
        xit "it adds to the existing source hash" do
          # given
          dsl = Prot.new
          dsl._last_name("Wyckoff").with(:map_target, "lname")
          dsl._full_name.with(:interpolate_format, "[first_name] [last_name]")
          source = {"first_name" => "Chris"}

          # when
          result = dsl.process(source)

          # expect
          result.should == {"full_name" => "Chris Wyckoff", "lname" => "Wyckoff"}
        end
      end
      describe "#to_hash" do
        xit "returns a valid hash to be consumed by the Proteus class" do
          # given
          dsl = Prot.new
          dsl._full_name.with(:interpolate_format, "[first_name] [last_name]").considering._first_name("George").with(:truncate_limit, 5).and(:uppercase)
          dsl._full_name.considering._last_name("South").with(:lowercase)

          # when
          hsh = dsl.to_hash

          # expect
          hsh.should == {
            "full_name" => [
              {"trans" => "interpolate", "format" => "[first_name] [last_name]"},
              {"sub_trans" =>
                {"first_name" => [
                    {"trans" => "truncate", "limit" => 5},
                    {"trans" => "uppercase"}
                  ],
                  "last_name" => [{"trans" => "lowercase"}]
                }
              }
            ]
          }
        end
      end
    end
  end
end

