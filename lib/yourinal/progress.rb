module Yourinal
  # Terminal Progress Indicator
  #
  #   Displays a starting message and an indicator each interval until the 
  #   passed block resolves. Good for showing that something takes a while 
  #   and is expected. Essentially a progress bar for unknown total/finish.
  #
  # message   - The string to be displayed at start
  # interval  - The time in between each indicator mark
  # indicator - The string displayed on each interval
  #
  # Examples:
  #
  #   connection_progress = Yourinal::Progress.new("Connecting to service, please wait")
  #   response = connection_progress.start {
  #     # Code that takes a while...
  #     # That you want to wait for...
  #   }
  #
  # Returns "Connecting to service, please wait" with "." for each second that passes
  #         Then connection_progress.start returns the result of the block.   
  #
  # Output  "Connecting to service, please wait...........done (10.69 seconds)"
  class Progress
    attr_accessor :results

    def initialize(message='Starting', interval=1.0)
      @message  = message
      @interval = interval
    end

    def start
      setup
      @results = yield
      teardown
    rescue => e
      raise "Failed: #{e.message}" 
    ensure
      kill_indicator
    end

    def kill_indicator
      return unless @indicator
      Process.kill 'TERM', @indicator
    end

    def start_indicator
      @indicator = fork { loop {print '.'; sleep @interval}}
    end

    def setup
      print @message
      @start_time = Time.now
      start_indicator
    end

    def teardown
      @end_time = Time.now
      kill_indicator
      print "done (#{sprintf('%.2f', total_time)} seconds)\n"
      @results
    end

    def total_time
      @end_time - @start_time
    end
  end
end
