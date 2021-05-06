require_relative './test_helper'

describe MacosTags do
  describe ".all_tags" do
    it "must returns tags list" do
      _(MacosTags.all_tags).must_be_kind_of(Array)
    end
  end
end
