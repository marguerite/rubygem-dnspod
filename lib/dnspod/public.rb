module DNSPod
  # The common POST parameters
  class Public
    def initialize
      @login_token = DNSPod::Config.new.login_token
    end

    def get
      { login_token: @login_token, format: DNSPod::FORMAT, lang: DNSPod::LANG }
    end
  end
end
