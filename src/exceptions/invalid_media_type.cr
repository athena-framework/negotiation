require "./negotiation_exception"

class Athena::Negotiation::Exceptions::InvalidMediaType < Athena::Negotiation::Exceptions::Exception
  getter type : String

  def initialize(@type : String, message : String? = nil, cause : Exception? = nil)
    super message, cause
  end
end
