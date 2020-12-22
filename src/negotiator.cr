require "./abstract_negotiator"

class Athena::Negotiation::Negotiator < Athena::Negotiation::AbstractNegotiator
  protected def match(accept : ANG::Accept, priority : ANG::Accept, index : Int32) : ANG::AcceptMatch?
    accept_base = accept.base_part
    priority_base = priority.base_part

    accept_sub = accept.sub_part
    priority_sub = priority.sub_part

    intercection = accept.parameters.each_with_object({} of String => String) do |(k, v), params|
      priority.parameters.tap do |pp|
        params[k] = v if pp.has_key?(k) && pp[k] == v
      end
    end

    base_equal = accept_base.downcase == priority_base.downcase
    sub_equal = accept_sub.downcase == priority_sub.downcase

    if (
         (accept_base == "*" || base_equal) &&
         (accept_sub == "*" || sub_equal) &&
         intercection.size == accept.parameters.size
       )
      score = 100 * (base_equal ? 1 : 0) + 10 * (sub_equal ? 1 : 0) + intercection.size

      return ANG::AcceptMatch.new accept.quality * priority.quality, score, index
    end

    return nil if !accept_sub.includes?('+') || !priority_sub.includes?('+')

    accept_sub, accept_plus = self.split_sub_part accept_sub
    priority_sub, priority_plus = self.split_sub_part priority_sub

    if (
         !(accept_base == "*" || base_equal) ||
         !(accept_sub == "*" || priority_sub == "*" || accept_plus == "*" || priority_plus == "*")
       )
      return nil
    end

    sub_equal = accept_sub.downcase == priority_sub.downcase
    plus_equal = accept_plus.downcase == priority_plus.downcase

    if (
         (accept_sub == "*" || priority_sub == "*" || sub_equal) &&
         (accept_plus == "*" || priority_plus == '*' || plus_equal) &&
         intercection.size == accept.parameters.size
       )
      # TODO: Calculate intercection between each header's parameters

      score = 100 * (base_equal ? 1 : 0) + 10 * (sub_equal ? 1 : 0) + (plus_equal ? 1 : 0) + intercection.size
      return ANG::AcceptMatch.new accept.quality * priority.quality, score, index
    end

    nil
  end

  private def split_sub_part(sub_part : String) : Array(String)
    return [sub_part, ""] unless sub_part.includes? '+'

    sub_part.split '+', limit: 2
  end

  private def create_header(header : String) : ANG::BaseAccept
    ANG::Accept.new header
  end
end
