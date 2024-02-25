require "httpclient"
require "nokogiri"

class StockScraperNotFound < StandardError; end
class TickerNotFound < StandardError; end

class StockScraper
  def self.class_for(source)
    cls = subclasses.find {|c| c.source_name == source }
    if cls.nil?
      raise StockScraperNotFound, "Source not found: #{source}"
    else
      cls
    end
  end

  def initialize(ticker)
    @ticker = ticker
    @doc = nil
  end

  attr_reader :ticker

  def fetch
    return @doc unless @doc.nil?

    url = make_url
    http = HTTPClient.new
    response = http.get(url)
    ticker_not_found! unless response.ok?
    @doc = Nokogiri::HTML5(response.body)
  end

  attr_reader :doc

  def extract
    {
      name: extract_name,
      price: extract_price,
      per: extract_per,
      pbr: extract_pbr,
      eps: extract_eps,
      dividend_yield: extract_dividend_yield
    }
  end

  def fetch_and_extract
    fetch
    extract
  end

  private def ticker_not_found!
    raise TickerNotFound, "Ticker not found: #{self.ticker}"
  end
end

require_relative "finviz_scraper"
