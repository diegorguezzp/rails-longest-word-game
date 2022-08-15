require "open-uri"
require "nokogiri"

class GamesController < ApplicationController
  def new
    arr = ('A'..'Z').to_a;
    @str = arr.sample(10);
  end

  def score

    @result = params[:guess].chars
    @letters = params[:str_value].chars
    count = 0;
    @found = false;
    @result.each_with_index do |letter, index|
      if @letters.include?(letter.capitalize)
        count += 1
        @letters[index] = "."
      end
    end
    if count == @result.length
      url = "https://wagon-dictionary.herokuapp.com/#{@result.join}"
      html_file = URI.open(url).read
      html = JSON.parse(html_file)
      @found = html["found"]
    end
  end
end
