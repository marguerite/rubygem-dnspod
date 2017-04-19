module DNSPod
  # The DNSPod API version
  class Version
    def raw
      DNSPod::Post.new('Info.Version').put
    end

    def get
      raw['status']['message']
    end
  end
end
