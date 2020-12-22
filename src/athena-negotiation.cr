require "./accept"
require "./accept_match"
require "./accept_charset"
require "./accept_encoding"
require "./accept_language"
require "./charset_negotiator"
require "./encoding_negotiator"
require "./language_negotiator"
require "./negotiator"

require "./exceptions/*"

# Convenience alias to make referencing `Athena::Negotiation` types easier.
alias ANG = Athena::Negotiation

module Athena::Negotiation
  # Returns an `ANG::Negotiation` singleton instance.
  class_getter(negotiator) { ANG::Negotiator.new }

  # Returns an `ANG::CharsetNegotiator` singleton instance.
  class_getter(charset_negotiator) { ANG::CharsetNegotiator.new }

  # Returns an `ANG::EncodingNegotiator` singleton instance.
  class_getter(encoding_negotiator) { ANG::EncodingNegotiator.new }

  # Returns an `ANG::LanguageNegotiator` singleton instance.
  class_getter(language_negotiator) { ANG::LanguageNegotiator.new }
end
