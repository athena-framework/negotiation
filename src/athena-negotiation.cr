require "./accept"
require "./accept_match"
require "./accept_charset"
require "./accept_encoding"
require "./accept_language"
require "./negotiator"

# Convenience alias to make referencing `Athena::Negotiation` types easier.
alias ANG = Athena::Negotiation

module Athena::Negotiation
end

# pp ANG::Accept.new "application/json;q=1.0"
# pp ANG::Accept.new "application/json ;q=1.0; level=2;foo= bar"
# pp ANG::Accept.new "text/html ; level = 2   ; q = 0.4"

# puts
# puts

# pp ANG::AcceptLanguage.new "en-gb;q=0.8"

n = ANG::Negotiator.new

pp n.best "text/html;level=1", ["text/html"]                                                      # text/html
pp n.best "text/*;q=0.7, text/html;q=0.3, */*;q=0.5, image/png;q=0.4", ["text/html", "image/png"] # image/png
