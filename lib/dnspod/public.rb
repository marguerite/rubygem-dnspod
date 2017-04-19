module DNSPod
  # The common POST parameters
  class Public
    def initialize
      config = DNSPod::Config.new.show
      @login_token = config['token_id'] + ',' + config['token']
    end

    def get
      { login_token: @login_token, format: DNSPod::FORMAT, lang: DNSPod::LANG }
    end
  end
end
