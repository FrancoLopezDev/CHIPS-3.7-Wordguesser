class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @num_wrong_guesses = 0
  end

  def guess(new_guess)
    if new_guess.nil? || new_guess.empty? || new_guess =~ /^[^A-Za-z]$/
	raise ArgumentError
    end

    new_guess = new_guess.downcase
    
    if @guesses.include?(new_guess)
	return !@guesses.include?(new_guess)
    elsif @wrong_guesses.include?(new_guess)
       return !@wrong_guesses.include?(new_guess)
    end

    if word.include?(new_guess)
    	@guesses += new_guess
    else
	@wrong_guesses += new_guess
        @num_wrong_guesses += 1
    end    

  end

  def word_with_guesses
    word_with_guesses = ''
    word.each_char do |char|
        if @guesses.include?(char)
           word_with_guesses += char
        else
           word_with_guesses += '-'
        end
    end
    return word_with_guesses
  end

  def check_win_or_lose
    if @num_wrong_guesses == 7
       return :lose
    elsif @word == word_with_guesses
       return :win
    else
       return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
