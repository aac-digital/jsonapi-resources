require 'jsonapi/formatter'

module JSONAPI
  class Configuration
    attr_reader :json_key_format,
                :key_formatter,
                :base_url,
                :toplevel_links,
                :serialize_has_many

    def initialize
      #:underscored_key, :camelized_key, :dasherized_key, or custom
      self.json_key_format = :underscored_key

      #:none | :href_only | :full
      self.toplevel_links = :none

      self.base_url = ''

      #:ids | :href
      self.serialize_has_many = :ids
    end

    def json_key_format=(format)
      @json_key_format = format
      @key_formatter = JSONAPI::Formatter.formatter_for(format)
    end

    def toplevel_links=(toplevel_links)
      raise ArgumentError.new(toplevel_links) unless [:none, :href, :full].include?(toplevel_links)
      @toplevel_links = toplevel_links
    end

    def base_url=(base_url)
      @base_url = base_url
    end

    def serialize_has_many=(serialize_has_many)
      raise ArgumentError.new(serialize_has_many) unless [:ids, :href].include?(serialize_has_many)
      @serialize_has_many = serialize_has_many
    end
  end

  class << self
    attr_accessor :configuration
  end

  @configuration ||= Configuration.new

  def self.configure
    yield(@configuration)
  end
end