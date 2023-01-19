class PostcodeChecker
  def valid?(postcode)
    (/^[a-z]{1,2}\d[a-z\d]?\s*\d[a-z]{2}$/i).match? postcode
  end
end