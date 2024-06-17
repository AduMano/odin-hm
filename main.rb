# frozen_string_literal: true

require('colorize')
require_relative('lib/game')
require_relative('lib/hang_man')

# Init
HANGMAN = HangMan.new
GAME = Game.new(HANGMAN)

GAME.start
