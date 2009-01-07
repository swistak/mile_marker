require 'erb'

module Thoughtbot
  module MileMarkerHelper
    def mile(detail="")
      return unless MileMarker.enabled?
      "mile=\"" + (detail.is_a?(Fixnum) ? "Milestone " : "") + "#{detail}\""
    end
  
    def initialize_mile_marker(request = nil)
      return unless MileMarker.enabled?
      MileMarker.initialize_mile_marker()
    end
  
    def add_initialize_mile_marker()
      init_code = initialize_mile_marker()
      return if init_code.nil? || init_code.empty?
      response.body.gsub! /<\/(head)>/i, init_code + '</\1>' if response.body.respond_to?(:gsub!)
    end
  end
    
  class MileMarker  
    # The environments in which to enable the Mile Marker functionality to run.  Defaults
    # to 'development' only.
    @@environments = ['development']

    @@javascript_library = 'prototype'

    class << self 
      attr_accessor :environments
    end

    def self.javascript_library=(library_name)
      unless %w(jquery prototype).include?(library_name)
        raise ArgumentError, "prototype and jquery are the only valid options for javascript_library"
      end

      @@javascript_library = library_name
    end

    def self.options
      @options ||= {
        :z_index => 1000,
        :background_color => "#000"
      }
    end

    # Return true if the Mile Marker functionality is enabled for the current environment
    def self.enabled?
      environments.include?(ENV['RAILS_ENV'])
    end
    
    def self.enable
      environments.push ENV['RAILS_ENV']
    end
    
    def self.disable
      environments.delete ENV['RAILS_ENV']
    end
    
    def self.initialize_mile_marker()
      erb = File.open(File.join(File.dirname(__FILE__), "#{@@javascript_library}_mile_marker.js.erb")).read
      ERB.new(erb).result(binding)
    end 
  end
end
