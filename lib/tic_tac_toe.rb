class TicTacToe

    attr_reader :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "

    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, player)
        board[index] = player
    end

    def position_taken?(index)
        if board[index] == " " || board[index] == " " || board[index] == nil
          false
        else
          true
        end
    end

    def valid_move?(index)
        if index.between?(0,8) && !position_taken?(index)
           return true
        end
    end

    def turn_count
        counter = 0
        board.each do |s|
           if s == "X" || s == "O"
              counter += 1
           end
        end
        counter
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Please enter 1-9:"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
           move(index, current_player)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.each do |single_win_combo|
            win_index_1 = single_win_combo[0]
            win_index_2 = single_win_combo[1]
            win_index_3 = single_win_combo[2]
            
            position_1 = board[win_index_1]
            position_2 = board[win_index_2]
            position_3 = board[win_index_3]

            if position_1 == position_2 && position_2 == position_3 && position_taken?(win_index_1)
                return single_win_combo
            end
        end
        false
    end

    def full?
        board.all? {|i| i == "X" || i == "O"}
    end

    def draw?
        !won? && full?
    end

    def over?
        if draw? || won? || full?
            true
        end
    end

    def winner
        won = ""
        if winner = won?
          won = board[winner.first]
        end
    end

    def play
        until over?
          turn
        end
    
        if won?
          winner = winner()
          puts "Congratulations #{winner}!"
        elsif draw?
          puts "Cat's Game!"
        end
    end
end
