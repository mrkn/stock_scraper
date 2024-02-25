require "stock_scraper"
require "finviz_scraper"

class FinvizScraperTest < Test::Unit::TestCase
  include FixtureReader
  include WithWebMock

  def setup
    @ticker = "NVDA"
    @scraper = FinvizScraper.new(@ticker)
    @html = read_fixture("NVDA.html")
  end

  sub_test_case("fetch_and_extract") do
    test("200 case") do
      stub_request(:get, "https://finviz.com/quote.ashx?t=#{@ticker}").to_return(body: @html)
      assert_nil @scraper.doc
      @scraper.fetch_and_extract
      assert_not_nil @scraper.doc
      assert_requested(:get, "https://finviz.com/quote.ashx?t=#{@ticker}")
    end

    test("404 case") do
      stub_request(:get, "https://finviz.com/quote.ashx?t=#{@ticker}").to_return(status: 404)
      assert_nil @scraper.doc
      assert_raise(TickerNotFound) do
        @scraper.fetch_and_extract
      end
      assert_nil @scraper.doc
      assert_requested(:get, "https://finviz.com/quote.ashx?t=#{@ticker}")
    end
  end
end
