##
#  Extension of base Log4r::Configurator to enable decoding of a `default`
#  attribute in the XML definition.
#
class Log4r::Configurator
  class << self
    alias :orig_decode_outputter :decode_outputter
  end

  ##
  # Decodes an outputter as normal, but also sets @default if it was defined in the given configuration file.
  def self.decode_outputter(e)
    orig_decode_outputter(e)
    Log4r::Outputter[e.value_of('name')].default = !!e.value_of('default')
  end
end
