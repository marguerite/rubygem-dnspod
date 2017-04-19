require 'yaml'

module DNSPod
  # Parse YAML configuration
  class Config
    def initialize
      @config = YAML.safe_load(open('config.yml', 'r:UTF-8').read)
    end

    def raw
      @config
    end

    def login_token
      @config['token_id'] + ',' + @config['token']
    end
  end
end
