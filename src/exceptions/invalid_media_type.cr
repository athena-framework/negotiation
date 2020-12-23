require "./negotiation_exception"

class Athena::Negotiation::Exceptions::InvalidMediaType < Athena::Negotiation::Exceptions::Exception
  def initialize(type : String, cause : Exception? = nil)
    super type, "Invalid media type: '#{type}'.", cause
  end
end
