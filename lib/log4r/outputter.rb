class Log4r::Outputter
  attr_accessor :default

  def self.default_outputters
    defaults = []
    each_outputter do |outputter|
      defaults << outputter if outputter.default?
    end

    return defaults
  end

  def default?
    !!@default
  end
end
