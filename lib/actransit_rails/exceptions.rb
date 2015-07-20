module ACTransitRails

  class Error < StandardError; end
  class APIAccessError < Error
    attr_reader :message, :code

    def initialize(message, code)
      @code = code
      @message = "ACTransit returned error: #{code} - #{message}"
      super(@message)
    end
  end

end