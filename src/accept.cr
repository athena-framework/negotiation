require "./base_accept"

struct Athena::Negotiation::Accept < Athena::Negotiation::BaseAccept
  getter base_part : String
  getter sub_part : String

  def initialize(value : String)
    super value

    @type = "*/*" if @type == "*"

    parts = @type.split '/'

    # TODO: Use more specific exception
    raise ANG::Exceptions::InvalidMediaType.new @type, "Invalid media type: '#{@type}'." if parts.size != 2 || !parts[0].presence || !parts[1].presence

    @base_part = parts[0]
    @sub_part = parts[1]
  end
end
