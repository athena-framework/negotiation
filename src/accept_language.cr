require "./base_accept"

struct Athena::Negotiation::AcceptLanguage < Athena::Negotiation::BaseAccept
  getter language : String
  getter script : String? = nil
  getter region : String? = nil

  def initialize(value : String)
    super value

    parts = @type.split '-'

    case parts.size
    when 2
      @language = parts[0]
      @region = parts[1]
    when 1
      @language = parts[0]
    when 3
      @language = parts[0]
      @script = parts[1]
      @region = parts[2]
    else
      raise ANG::Exceptions::InvalidLanguage.new @type
    end
  end
end
