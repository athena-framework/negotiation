abstract struct Athena::Negotiation::BaseAccept
  getter quality : Float32 = 1.0
  getter normalized_value : String
  getter value : String
  getter parameters : Hash(String, String) = Hash(String, String).new
  getter type : String

  def initialize(@value : String)
    # type, parameters = self.parse_accept_value value
    parts = @value.split ';'
    @type = parts.shift.strip.downcase

    parts.each do |part|
      part = part.split '='

      # Skip invalid parameters
      next unless part.size == 2

      @parameters[part[0].strip.downcase] = part[1].strip(" \"")
    end

    if quality = @parameters.delete "q"
      @quality = quality.to_f32
    end

    @normalized_value = String.build do |io|
      io << @type

      unless @parameters.empty?
        io << "; "
        # TODO: Do we care the parameters aren't sorted?
        parameters.join(io, "; ") { |(k, v), io| io << "#{k}=#{v}" }
      end
    end
  end
end
