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
  class_getter(negotiator) { ANG::Negotiator.new }
end
