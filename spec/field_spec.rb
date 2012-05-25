require 'spec_helper'

module Protean
  describe Field do
    describe "#transform" do
      it "processes sub transformations" do
        # given
        transformations = [
          {"trans" => "concatenate", "separator" => ", ", "format" => "last_name, first_name"},
          {"sub_trans" => {"first_name" => [{"trans" => "uppercase"}], "last_name" => [{"trans" => "truncate", "limit" => "2"}]}}
        ]
        field_name = "full_name"
        source = {"first_name" => "Chris", "last_name" => "Wycoff"}
        f = Field.new([field_name, transformations])

        result = f.transform(source)

        result["full_name"].should == "Wy, CHRIS"
      end
    end
  end
end
