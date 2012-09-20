##
#  Extension of base Log4r::Outputter class to add @default as an attribute
#  and a class-level method to retrieve all outputters that have that attribute
#  set.
#
class Log4r::Outputter
  attr_accessor :default

  ##
  # Gathers all outputters that have @default set
  def self.default_outputters
    defaults = []
    each_outputter do |outputter|
      defaults << outputter if outputter.default?
    end

    return defaults
  end

  ##
  # Returns whether or not @default has been set
  def default?
    !!@default
  end
end
