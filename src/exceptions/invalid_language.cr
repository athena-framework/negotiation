require "./negotiation_exception"

class Athena::Negotiation::Exceptions::InvalidLanguage < Athena::Negotiation::Exceptions::Exception
  def initialize(type : String, cause : Exception? = nil)
    super type, "Invalid language: '#{type}'.", cause
  end
end
