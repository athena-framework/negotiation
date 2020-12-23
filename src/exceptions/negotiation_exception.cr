abstract class Athena::Negotiation::Exceptions::Exception < ::Exception
  getter type : String

  def initialize(@type : String, message : String? = nil, cause : Exception? = nil)
    super message, cause
  end
end
