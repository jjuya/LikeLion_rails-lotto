require 'httparty'
require 'nokogiri'
require 'json'

# https://stackoverflow.com/questions/18320642/parsing-json-in-controller-w-httparty

uri = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="

response = HTTParty.get(uri)

# hash 값을 리턴해 준다.
lotto_info = JSON(response.body)

# puts lotto_info

# arr = Array.new
# arr << lotto_info["drwtNo1"]
# arr << lotto_info["drwtNo2"]
# arr << lotto_info["drwtNo3"]
# arr << lotto_info["drwtNo4"]
# arr << lotto_info["drwtNo5"]
# arr << lotto_info["drwtNo6"]

drw_numbers = []

lotto_info.each do |key, value|
    drw_numbers << value if key.include? 'drwtNo'
end

bonus_number = lotto_info["bnusNo"]

# puts drw_numbers
# puts bonus_number

lotto = [*1..45].sample(6)

puts lotto & drw_numbers