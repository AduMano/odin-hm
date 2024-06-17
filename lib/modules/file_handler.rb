# frozen_string_literal: true

require('msgpack')

# Module
module FileHandler
  def load_dictionary_word(letter_length)
    unless File.exist?('dictionary.txt')
      puts 'Dictionary not found. Exiting Program...'
      exit(0)
    end

    dictionary = File.readlines('dictionary.txt').select { |word| word.chomp.length == letter_length }
    dictionary[rand(0..dictionary.length)].chomp
  end

  def load_state
    save_file = File.read('save.state')
    MessagePack.load(save_file)
  end

  def save_state(data)
    save_data = MessagePack.dump(data)
    File.write('save.state', save_data)

    true
  rescue StandardError
    false
  end

  def load_hangman
    if File.exist?('states.data')
      begin
        hangman_file = File.read('states.data')
        return MessagePack.load(hangman_file)
      rescue StandardError
        return 'File unable to load.'
      end
    end

    'Hang Man not found.'
  end
end
