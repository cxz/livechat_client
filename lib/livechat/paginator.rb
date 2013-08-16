module LiveChat
  module Paginator
    include Enumerable

    attr_reader :query

    def clear_cache
      @cache = nil
      @query = {}
    end

    # number of results to return per page
    def per_page(count=15)
      @query[:per_page] = count
      self
    end

    def page(number)
      @query[:page] = number
      self
    end

    # TODO: API v2
    # def next_page?
    #   fetch if @cache.nil?
    #   !!@cache["next_page"]
    # end

    # TODO: API v2
    # def fetch_next_page
    #   if next_page?
    #     @cache = get(@cache["next_page"])
    #   end
    # end

    # fetches actual result of request
    def fetch(force=false)
      if @cache.nil? || force
        options = query.dup
        @cache = get(options.delete(:path), options)
      end
      @cache
    end

    # call block once for each element in self
    def each
      fetch.each {|result| yield result}
    end

    def [](idx)
      fetch[idx]
    end

    def method_missing(method, *args)
      fetch.send(method, *args)
    end
  end
end
