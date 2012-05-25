require 'spec_helper'

module Protean
  module Transformations
    class Rogue < Base
      def process(shape)
        shape.original[shape.key] = "a new value"
      end
    end
  end
end

describe Proteus do

  describe "#process" do

    let(:config) {
      {
        "first_name" => [{"trans" => "map", "target" => "fname"}],
        "last_name" => [{"trans" => "map", "target" => "lname"}],
        "address" => [{"trans" => "map", "target" => "addr"}],
      }
    }
    let(:proteus) { Proteus.new(config) }
    let(:source) { {"first_name" => "Chris", "last_name" => "Wyckoff", "address" => "123 Main St."} }

    it "returns a hash" do
      proteus.process(source).should be_a_kind_of(Hash)
    end

    it "freezes the source" do
      transformations = {
        "first_name" => [
                         {"trans" => "rogue"}
                        ]
      }

      p = Proteus.new(transformations)

      lambda { p.process({:first_name => "Chris"}) }.should raise_error(Protean::ProteusImmutableSourceError)
    end

    it "applies transformations to data" do
      # when
      lead = proteus.process(source)

      # expect
      %w[fname lname addr].each do |key|
        lead.should have_key(key)
      end
    end

    it "applies multiple transformations per field" do
      # given
      transformations = {
        "first_name" => [
                         {"trans" => "lowercase"},
                         {"trans" => "truncate", "limit" => 4},
                         {"trans" => "map", "target" => "fname"}
                        ]
      }
      p = Proteus.new(transformations)

      # when
      data = p.process(source)

      # expect
      data["fname"].should == "chri"
    end

    it "applies multiple transformations regardless of when the key transformation occurs" do
      # given
      transformations = {
        "first_name" => [
          {"trans" => "lowercase"},
          {"trans" => "map", "target" => "fname"},
          {"trans" => "truncate", "limit" => 4}
        ]
      }
      p = Proteus.new(transformations)

      # when
      data = p.process(source)

      # expect
      data["fname"].should == "chri"
    end

    it "handles complicated concatenate transformations" do
      # given
      name - concatenate

      -- first_name
      --- lowercase

      -- last_name
      --- truncate

      transformation = {
        "name" => [
          {"trans" => "concatenate", "separator" => ", ", format = "last_name, first_name",
            "sub_trans" => {
              "first_name" => [{"trans" => "lowercase"}]
              "last_name" => [{"trans" => "truncate", "limit" => "5"}]
            }
          }
        ]
      }

      first step
      original = {:first_name => "Chris", :last_name => "Wyckoff"}

      # after subs
      # lowercase and uppercase
      target = {:name => "", :first_name => "chris", :last_name => "WYCKOFF"}

      # fianl
      target = {:name => "Chris Wy"}


          p = Proteus.new(transformations)

      # when
      data = p.process(source)

      # expect
      data["fname"].should == "chri"
    end

    xit "orders fields in the order specified" do
      prepping = {
        "first_name" => [{
                           "prep" => "map",
                           "target" => "fname"
                         }],
        "last_name" => [{
                          "prep" => "map",
                          "target" => "lname"
                        }],
        "address" => [{
                        "prep" => "map",
                        "target" => "addr"
                      }],
        "phone" => [{
                      "prep" => "map",
                      "target" => "phone_num"
                    }],
        "email_address" => [{
                              "prep" => "map",
                              "target" => "email"
                            }],
        "_order" => ["email_address","last_name", "phone", "address", "first_name"]
      }
      field_prepper = Proteus.new(prepping)

      # when
      lead = field_prepper.process(@source)

      # expect
      lead.to_a.first.should include("email")
      lead.to_a.last.should include("fname")
    end
  end

end
