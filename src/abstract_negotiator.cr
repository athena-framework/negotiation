abstract class Athena::Negotiation::AbstractNegotiator
  private abstract def create_header(header : String) : ANG::BaseAccept

  def best(header : String, priorities : Indexable(String), strict : Bool = false) : ANG::BaseAccept?
    raise ArgumentError.new "priorities should not be empty." if priorities.empty?
    raise ArgumentError.new "The header string should not be empty." if header.blank?

    accepted_headers = Array(ANG::BaseAccept).new

    self.parse_header(header) do |h|
      accepted_headers << self.create_header h
    rescue ex
      raise ex if strict
    end

    accepted_priorties = priorities.map &->create_header(String)

    matches = self.find_matches accepted_headers, accepted_priorties

    specific_matches = matches.reduce({} of Int32 => ANG::AcceptMatch) do |matches, match|
      ANG::AcceptMatch.reduce matches, match
    end.values

    specific_matches.sort!

    match = specific_matches.shift?

    match.nil? ? nil : accepted_priorties[match.index]
  end

  protected def match(header : ANG::BaseAccept, priority : ANG::BaseAccept, index : Int32) : ANG::AcceptMatch?
    accept_type = header.type
    priority_type = priority.type

    equal = accept_type.downcase == priority_type.downcase

    if equal || accept_type == "*"
      return ANG::AcceptMatch.new header.quality * priority.quality, 1 * (equal ? 1 : 0), index
    end

    nil
  end

  private def parse_header(header : String, & : String ->) : Nil
    header.scan /(?:[^,\"]*+(?:"[^"]*+\")?)+[^,\"]*+/ do |match|
      yield match[0] unless match[0].blank?
    end
  end

  private def find_matches(headers : Array(ANG::BaseAccept), priorities : Indexable(ANG::BaseAccept)) : Array(ANG::AcceptMatch)
    matches = [] of ANG::AcceptMatch

    priorities.each_with_index do |priority, idx|
      headers.each do |header|
        if match = self.match(header, priority, idx)
          matches << match
        end
      end
    end

    matches
  end
end
