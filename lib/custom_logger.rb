# encoding: utf-8
require 'log4r'
require 'log4r/outputter/datefileoutputter.rb'
module Log4r
  class Logger
    alias_method :add_formatter, :add
    def add(*params)
      # do nothing
    end
  end
#  class PatternFormatter
#    def format(event)
#      if event.data.present?
#        sprintf("%s [%*s] %s\n", DateTime.now.strftime("%Y-%m-%d %H:%M:%S"),
#          MaxLevelLength,
#          LNAMES[event.level],
#          event.data)
#      else
#        sprintf("fdsgsd")
#      end
#    end
#  end
#  class DateFileOutputter < FileOutputter
#    private
#    def write(data)
#      change if requiresChange
#      @out.print "data_blank"
#      super
#    end
#  end
end
module CustomLogger
  class SystemLogger
    include Singleton
    def initialize
      unless @logger
        path =
          if Rails.env.production?
            "/tmp"
          else
            Rails.root.join("log", Rails.env)
          end
        @logger = Log4r::Logger.new("SYSTEM")
        formatter = Log4r::PatternFormatter.new(
          pattern: "%d,%l,%h,%M",
          date_format: "%Y/%m/%d %H:%M:%S"
        )
        outputter = Log4r::DateFileOutputter.new(
          "file",
          dirname: path,
          filename: 'sakura_brain.log',
          date_pattern: "%Y%m%d",
#          level: if Rails.env.production? then Log4r::INFO else Log4r::DEBUG end,
          level: Log4r::DEBUG,
          formatter: formatter
        )
        @logger.add_formatter(outputter)
      end
    end
    def logger
      @logger
    end
  end
end