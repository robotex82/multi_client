module MultiClient
  class NoSubdomain
    def self.matches?(request)
      case request.subdomain
      when *MultiClient::Configuration.no_subdomain_prefixes.call(request)
        true
      else
        false
      end
    end
  end
end
