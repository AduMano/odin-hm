# string_literal_frozen: false

require('colorize')

# Init
HANGMAN = HangMan.new
GAME = Game.new(HANGMAN)

GAME.start
