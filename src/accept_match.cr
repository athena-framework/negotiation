struct Athena::Negotiation::AcceptMatch
  getter quality : Float32
  getter score : Int32
  getter index : Int32

  def initialize(@quality : Float32, @score : Int32, @index : Int32); end
end
