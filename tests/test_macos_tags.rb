require_relative './test_helper'

describe MacosTags do
  describe ".all_tags" do
    it "must returns tags list" do
      _(MacosTags.all_tags).must_be_kind_of(Array)
    end
  end

  describe MacosTags::TagParser do
    it "must returns empty list if no tags are found" do
      Tempfile.create('tag_parser_test', '/tmp') do |f|
        _(MacosTags::TagParser.new(f).tags).must_equal([])
      end
    end
  end
end
