class FinvizExtractor
  XPATHS = {
    name: "/html/body/div[3]/div[3]/div[1]/div/div[1]/div[1]/div/h2",
    price: "/html/body/div[3]/div[3]/div[4]/table/tbody/tr/td/div/table[1]/tbody/tr/td/div[2]/table/tbody/tr[12]/td[12]",
    per: "/html/body/div[3]/div[3]/div[4]/table/tbody/tr/td/div/table[1]/tbody/tr/td/div[2]/table/tbody/tr[1]/td[4]",
    pbr: "/html/body/div[3]/div[3]/div[4]/table/tbody/tr/td/div/table[1]/tbody/tr/td/div[2]/table/tbody/tr[5]/td[4]",
    eps: "/html/body/div[3]/div[3]/div[4]/table/tbody/tr/td/div/table[1]/tbody/tr/td/div[2]/table/tbody/tr[1]/td[6]",
    dividend_yield: "/html/body/div[3]/div[3]/div[4]/table/tbody/tr/td/div/table[1]/tbody/tr/td/div[2]/table/tbody/tr[7]/td[2]",
  }

  REGEXPS = {
    dividend_yield: /\d+\.\d+%/
  }

  def initialize(doc)
    @doc = doc
  end

  attr_reader :doc

  def extract_name
    doc.xpath(XPATHS[:name])[0].inner_text.strip
  end

  def extract_price
    doc.xpath(XPATHS[:price])[0].inner_text
  end

  def extract_per
    doc.xpath(XPATHS[:per])[0].inner_text
  end

  def extract_pbr
    doc.xpath(XPATHS[:pbr])[0].inner_text
  end

  def extract_eps
    doc.xpath(XPATHS[:eps])[0].inner_text
  end

  def extract_dividend_yield
    text = doc.xpath(XPATHS[:dividend_yield])[0].inner_text
    REGEXPS[:dividend_yield].match(text)[0]
  end
end
