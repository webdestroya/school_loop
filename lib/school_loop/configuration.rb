module SchoolLoop
  module Configuration
    VALID_OPTIONS_KEYS = [
      :username,
      :password,
      :subdomain,

      :secure,

      :adapter,
      :user_agent,
      :connection_options,
      :debug,
    ].freeze

    DEFAULT_ADAPTER = :net_http

    DEFAULT_USERNAME = nil
    DEFAULT_PASSWORD = nil
    DEFAULT_SUBDOMAIN = nil

    DEFAULT_USER_AGENT = "School Loop Ruby API v#{SchoolLoop::VERSION}".freeze

    DEFAULT_CONNECTION_OPTIONS = {}

    attr_accessor *VALID_OPTIONS_KEYS

    def configure
      yield self
    end

    def self.extended(base)
      base.set_defaults
    end

    def options
      options = { }
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    def set_defaults
      self.adapter            = DEFAULT_ADAPTER
      self.user_agent         = DEFAULT_USER_AGENT
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.username           = DEFAULT_USERNAME
      self.subdomain          = DEFAULT_SUBDOMAIN
      self.password           = DEFAULT_PASSWORD
      self.secure             = true
      self.debug              = false
      self
    end
  end
end
