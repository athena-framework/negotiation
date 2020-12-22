require "./abstract_negotiator"

class Athena::Negotiation::EncodingNegotiator < Athena::Negotiation::AbstractNegotiator
  private def create_header(header : String) : ANG::BaseAccept
    ANG::AcceptEncoding.new header
  end
end
