# frozen_string_literal: true

# User Input Module
module UserInputs
  def new_game_or_load?
    loop do
      puts "Choose an action:\n [1] New Game\n [2] Continue Last Save\n\n"
      print 'Enter your choice: '
      choice = gets.chomp

      return choice if choice.eql?('1') || (choice.eql?('2') && File.exist?('save.state'))

      if choice.eql?('2') && !File.exist?('save.state')
        puts "\nSave File not found.\n".colorize(:red)
      else
        puts "\nInvalid Input.\n".colorize(:red) end
    end
  end

  def input_difficulty
    loop do
      puts "\nSet Difficulty Level:\n [1] Easy (5 - 7 Letters)\n [2] Normal (8 - 10 Letters)"
      puts " [3] Hard (11 - 12 Letters)\n\n"
      print 'Enter your choice: '
      choice = gets.chomp

      return choice if choice.eql?('1') || choice.eql?('2') || choice.eql?('3')

      puts "Invalid Input.\n".colorize(:red)
    end
  end

  def save_game?
    loop do
      print "\nDo you want to save your progress? Y/N: "
      choice = gets.chomp

      return true if choice.downcase.eql?('y')
      return false if choice.downcase.eql?('n')

      puts "Invalid Input.\n".colorize(:red)
    end
  end

  def input_guess(guesses)
    loop do
      print "\nGuess the character: "
      guess = gets.chomp.upcase

      if guesses.include?(guess) && guess.length.eql?(1)
        puts 'You have already entered that letter.'.colorize(:red)
      elsif guess.downcase.match?(/^[a-zA-Z]$/) && guess.length.eql?(1)
        return guess
      else
        puts "Invalid Input.\n".colorize(:red) end
    end
  end
end
