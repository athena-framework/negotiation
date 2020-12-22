abstract struct Athena::Negotiation::BaseAccept
  getter quality : Float32 = 1.0
  getter normalized_value : String
  getter value : String
  getter parameters : Hash(String, String)
  getter type : String

  def initialize(@value : String)
    # type, parameters = self.parse_accept_value value
    parts = @value.split ';'
    @type = parts.shift.strip.downcase

    @parameters = parts.to_h do |part|
      part = part.split '='

      # TODO: Use more specific exception
      raise ArgumentError.new "Invalid header: '#{@value}'." unless part.size == 2

      {part[0].strip.downcase, part[1].strip(" \"")}
    end

    if quality = @parameters.delete "q"
      @quality = quality.to_f32
    end

    @normalized_value = String.build do |io|
      io << @type

      unless @parameters.empty?
        io << "; "
        parameters.join(io, "; ") { |(k, v), io| io << "#{k}=#{v}" }
      end
    end
  end
end
