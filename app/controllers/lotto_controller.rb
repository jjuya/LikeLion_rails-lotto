class LottoController < ApplicationController
  
  
  def index
  end

  def show
    # https://m.blog.naver.com/PostView.nhn?blogId=crazytta&logNo=220322383157&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
    # http://konkuk.likelion.org/material-w3-api
    # https://manana.kr/lotto/simple
    require 'open-uri'
    require 'json'
    
    @lotto = [*1..45].sample(6)
  end
  
  def api
    require 'httparty'
    require 'json'
    
    uri = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
    
    response = HTTParty.get(uri)
    
    lotto_info = JSON.parse(response.body)
    
    @drwtNos = []
    
    lotto_info.each do |key, value|
      @drwtNos << value if key.include? 'drwtNo'
    end
    
    @bonus_number = lotto_info["bnusNo"]
    
    # lotto 담긴 숫자와 drwtNos에 담긴 숫자를 비교
    # 6개 다 맞으면 1등
    # 5개 맞으면 2등
    # 4개 맞으면 3등
    # 3개 맞으면 4등
    # 2개 맞으면 5등
    # 1개 맞으면 6등
    
    # https://stackoverflow.com/questions/13558461/how-to-find-matching-values-in-ruby-array
    @lotto = [*1..45].sample(6)
    # @lotto = [19, 12, 6, 41, 34, 1] 
    
    @matching = @lotto  & @drwtNos
    
    # @matching.conut
    case @matching.length
    when 6
      @result = "1등"
    when ((@lotto.include?(@bonus_number)) && 5 )
      @result = "2등"
    when 5
      @result = "3등"
    when 4
      @result = "4등(5만원)"
    when 3
      @result = "5등(5천원)"
    else
      @result = "꽝"
    end
    
  end
end
