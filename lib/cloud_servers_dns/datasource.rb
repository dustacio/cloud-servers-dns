require 'fog'
module CloudServersDNS
  class Datasource
    attr_reader :cache, :options, :connection, :domains, :ttl
    
    def initialize(opts={})
      @options = opts
      @connection = opts[:connection]
      @domains = opts[:domains]
      @ttl = opts[:ttl]
      # Build the initial cache
      build_cache
    end
    
    def compute
      Fog::Compute.new(connection)
    end
    
    def build_cache
      puts "build cache"
      Mutex.new.synchronize do
        @cache = {}
        compute.servers.each do |server|
          name = server.name
          ip_v4_address = server.ipv4_address
          @cache[name] = {
            ipv4_address: server.ipv4_address,
            ipv6_address: server.ipv6_address,
            expires_at: Time.now + ttl
          }
        end
      end
      @cache
    end

    def cached_results(key)
      if cache.key?(key)
        puts "HAVE RESULTS FOR #{key}"
        record = cache[key]
        if (record[:expires_at] > Time.now)
          puts "RESULTS IN WINDOW of TTL"
          return cache[key][:ipv4_address]
        else
          puts "OLD RECORD"
          build_cache
          return cache[key][:ipv4_address]
        end
      else
        puts "MISS"
        build_cache
        return cache[key][:ipv4_address] if cache.key?(key)
      end
    end

    def dotted_domain(domain)
      domain.start_with?('.') ? domain : ".#{domain}"
    end

    # nginx.test.example.com => test
    # test.example.com => test
    def host_from_wildcard(question)
      domains.each do |domain|
        dd = dotted_domain(domain)
        if question.index(dd)
          host = question[0, question.index(dd)]
          return Array(host.split('.')).last
        end
      end
      nil
    end

    # if you don't want wildcard support
    # this will only return the host
    def host_from_fqdn(question)
      domains.each do |domain|
        dd = dotted_domain(domain)
        if question.index(dd)
          host = question[0, question.index(dd)]
        end
      end
      nil
    end

    def lookup(host_name)
      cached_results(host_from_wildcard(host_name.to_s))
    end
  end
end
