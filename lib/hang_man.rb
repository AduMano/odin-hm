# frozen_string_literal: true

require_relative('modules/file_handler')

# Hang Man Class
class HangMan
  include FileHandler

  def initialize
    @hangman_states = load_hangman
  end

  def render_hangman(state)
    puts "\nStatus: ".colorize(:yellow)
    puts @hangman_states[state]
  end
end
