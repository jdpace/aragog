module Aragog
  module Dsl

    def crawl(path, &block)
      crawler_config = configuration.dup
      yield(crawler_config) if block_given?

      with_config(crawler_config) do
        crawler = Aragog::Crawler.new(path)
        crawler.crawl
      end
    end

  end
end

Aragog.extend(Aragog::Dsl)
