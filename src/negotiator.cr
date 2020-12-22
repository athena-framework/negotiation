require "./abstract_negotiator"

class Athena::Negotiation::Negotiator < Athena::Negotiation::AbstractNegotiator
  private def create_header(header : String) : ANG::BaseAccept
    ANG::Accept.new header
  end
end
