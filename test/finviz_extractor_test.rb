require "finviz_extractor"
require "nokogiri"

class FinvizExtractorTest < Test::Unit::TestCase
  include FixtureReader

  data({
    "NVIDIA"         => ["NVDA", "NVIDIA Corp"],
    "GlobalNetLease" => ["GNL",  "Global Net Lease Inc"],
    "AT&T"           => ["T",    "AT&T, Inc."],
    "TSMC"           => ["TSM",  "Taiwan Semiconductor Manufacturing ADR"],
  })
  test("extract_name") do |data|
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_name
  end

  data({
    "NVIDIA"         => ["NVDA", "788.17"],
    "GlobalNetLease" => ["GNL",  "7.62"],
    "AT&T"           => ["T",    "16.80"],
    "TSMC"           => ["TSM",  "129.53"],
  })
  test("extract_price") do |data|
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_price
  end

  data({
    "NVIDIA"         => ["NVDA", "66.03"],
    "GlobalNetLease" => ["GNL",  "-"],
    "AT&T"           => ["T",    "8.56"],
    "TSMC"           => ["TSM",  "24.99"],
  })
  test("extract_per") do |data|
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_per
  end

  data({
    "NVIDIA"         => ["NVDA", "45.19"],
    "GlobalNetLease" => ["GNL",  "0.63"],
    "AT&T"           => ["T",    "1.16"],
    "TSMC"           => ["TSM",  "6.48"],
  })
  test("extract_pbr") do |data|
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_pbr
  end

  data({
    "NVIDIA"         => ["NVDA", "11.94"],
    "GlobalNetLease" => ["GNL",  "-1.65"],
    "AT&T"           => ["T",    "1.96"],
    "TSMC"           => ["TSM",  "5.18"],
  })
  test("extract_eps") do |data|
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_eps
  end

  data({
    "NVIDIA"         => ["NVDA", "0.02%"],
    "GlobalNetLease" => ["GNL",  "20.34%"],
    "AT&T"           => ["T",    "6.67%"],
    "TSMC"           => ["TSM",  "1.68%"],
  })
  test("extract_dividend_yield") do
    ticker, expected_value = *data
    doc = load_finviz_html(ticker)
    assert_equal expected_value, FinvizExtractor.new(doc).extract_dividend_yield
  end

  private def load_finviz_html(ticker)
    html = read_fixture("#{ticker}.html")
    Nokogiri::HTML5(html)
  end
end
