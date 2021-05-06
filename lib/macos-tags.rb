require 'ffi-xattr'
require 'cfpropertylist'

module MacosTags
  XATTR_TAGS = "com.apple.metadata:_kMDItemUserTags"
  XATTR_FINDER_INFO = "com.apple.FinderInfo"
  ALL_TAGS_PLIST_PATH = "#{Dir.home}/Library/SyncedPreferences/com.apple.finder.plist"

  class Color
    DEFINITIONS = {
      none: 0,
      gray: 1,
      green: 2,
      purple: 3,
      blue: 4,
      yellow: 5,
      red: 6,
      orange: 7,
    }

    attr_reader :name, :value

    def initialize(_value)
      @name, @value = DEFINITIONS.find { |k,v| v == _value } || [:none, 0]
    end

    def inspect
      "#<MacosTags::Color @name=\"#{name}\" @value=#{value}>"
    end
  end

  def all_tags
    FinderPlist.new.tags
  end
  module_function :all_tags

  def find_files(tag:)
    Mdfinder.find_files(tag_name: tag)
  end
  module_function :find_files

  def count(tag:)
    Mdfinder.count(tag_name: tag)
  end
  module_function :count

  def tags(file:)
    TagParser.new(file).tags
  end
  module_function :tags

  class Mdfinder
    def self.count(tag_name:)
      new.count(tag_name: tag_name)
    end

    def self.find_files(tag_name:)
      new.find_files(tag_name: tag_name)
    end

    def count(tag_name:)
      _count(tag_query(tag_name))
    end

    def find_files(tag_name:)
      _query(tag_query(tag_name))
    end

    private

    def _count(query)
      ret = _query("-count", query)
      ret[0].to_i
    end

    def _query(*params)
      `mdfind #{Shellwords.join(params)}`.split("\n")
    end

    def tag_query(tag)
      "kMDItemUserTags == \"#{tag}\""
    end
  end

  class Tag < Struct.new(:label, :color, keyword_init: true)
  end

  class FinderPlist
    attr_reader :plist
    def initialize
      @plist = CFPropertyList::List.new
      load
    end

    def tags
      parse_find_tags.map do |v|
        Tag.new(label: v.value["n"].value, color: Color.new(v.value["l"].value))
      end
    end

    private

    def load
      plist.load_binary(ALL_TAGS_PLIST_PATH)
    end

    def parse_find_tags
      plist.value.value["values"].value["FinderTagDict"].value["value"].value["FinderTags"].value
    rescue
      []
    end
  end

  class TagParser
    attr_reader :xattr, :plist
    def initialize(file)
      @xattr = Xattr.new(file)
      @plist = CFPropertyList::List.new
    end

    def tags
      parse_raw_tags.value.map do |raw_tag|
        label, color_val = raw_tag.value.split("\n")
        Tag.new(label: label, color: Color.new(color_val.to_i))
      end
    end

    private

    def parse_raw_tags
      plist.load_binary_str(xattr[XATTR_TAGS])
    end
  end
end
