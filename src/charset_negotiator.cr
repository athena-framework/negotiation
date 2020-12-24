require "./abstract_negotiator"

# A `ANG::AbstractNegotiator` implementation to negotiate `ANG::AcceptCharset` headers.
class Athena::Negotiation::CharsetNegotiator < Athena::Negotiation::AbstractNegotiator
  private def create_header(header : String) : ANG::BaseAccept
    ANG::AcceptCharset.new header
  end
end
