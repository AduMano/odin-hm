# frozen_string_literal: true

require_relative('modules/file_handler')
require_relative('modules/user_inputs')

# Game Class
class Game
  include FileHandler
  include UserInputs

  def initialize(hangman)
    @hangman = hangman
    @word = ''
    @difficulty = 0
    @guesses = []
    @hangman_state = 0
    @loaded = false
  end

  def start
    puts "========================\n=====-| HANG MAN |-====="
    puts '========================'

    game_state = new_game_or_load?

    if game_state.eql?('1')
      word_setup(input_difficulty)
    else
      @loaded = true
      load_data(load_state)
    end

    play
  end

  def word_setup(difficulty_level)
    letter_range = {
      '1' => rand(5..7),
      '2' => rand(7..10),
      '3' => rand(11..12)
    }

    @difficulty = difficulty_level.to_i
    @word = load_dictionary_word(letter_range[difficulty_level])
  end

  def load_data(data)
    @word = data['word']
    @difficulty = data['difficulty']
    @guesses = data['guesses']
    @hangman_state = data['hangman_state']
  end

  def save_data
    return unless save_game?

    data = {
      word: @word,
      difficulty: @difficulty,
      guesses: @guesses,
      hangman_state: @hangman_state
    }

    save_state(data)
  end

  def play
    loop do
      render_game
      puts ''
      check_state
      save_data if @guesses.length.positive? && @loaded.eql?(false)
      guess

      @loaded = false
    end
  end

  def check_state
    game_over('lose') if @hangman_state.eql?(8)
  end

  def guess
    guess = input_guess(@guesses)
    @guesses.push(guess.upcase)

    return if check_guess(guess.downcase)

    @hangman_state += 1
  end

  def check_guess(guess)
    return false unless @word.split('').include?(guess)

    game_over('win') if @word.split('').all? { |letter| @guesses.include?(letter.upcase) }

    true
  end

  def render_game
    @hangman.render_hangman(@hangman_state)

    puts "\nDifficulty: #{if @difficulty.eql?(1)
                            'EASY'
                          else
                            @difficulty.eql?(2) ? 'NORMAL' : 'HARD'
                          end}"
    puts "Guesses: #{@guesses.map!(&:upcase).join(', ')}"

    print 'Word: '.colorize(:yellow)
    @word.split('').each { |letter| print @guesses.include?(letter.upcase) ? "#{letter.upcase} " : '_ ' }
  end

  def game_over(condition)
    puts "\nYou have been hanged! The word is: #{@word.upcase}" if condition.eql?('lose')
    puts "\nYou did it! You successfully guessed the word: #{@word.upcase}" if condition.eql?('win')

    exit(0)
  end
end
