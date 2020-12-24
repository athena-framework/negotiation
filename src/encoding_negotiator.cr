require "./abstract_negotiator"

# A `ANG::AbstractNegotiator` implementation to negotiate `ANG::AcceptEncoding` headers.
class Athena::Negotiation::EncodingNegotiator < Athena::Negotiation::AbstractNegotiator
  private def create_header(header : String) : ANG::BaseAccept
    ANG::AcceptEncoding.new header
  end
end
