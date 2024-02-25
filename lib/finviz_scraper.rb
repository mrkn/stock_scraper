require "forwardable"
require_relative "finviz_extractor"

class FinvizScraper < StockScraper
  extend Forwardable
  def self.source_name
    "finviz".freeze
  end

  def make_url
    "https://finviz.com/quote.ashx?t=#{self.ticker}"
  end

  def_delegators :extractor, :extract_name,
                             :extract_price,
                             :extract_per,
                             :extract_pbr,
                             :extract_eps,
                             :extract_dividend_yield

  private def extractor
    @extractor ||= FinvizExtractor.new(self.doc)
  end
end
