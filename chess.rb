BLACK_KING = "\u265A".encode('utf-8')
BLACK_QUEEN = "\u265B".encode('utf-8')
BLACK_KNIGHT = "\u265E".encode('utf-8')
BLACK_BISHOP = "\u265D".encode('utf-8')
BLACK_PAWN = "\u265F".encode('utf-8')
BLACK_ROOK = "\u265C".encode('utf-8')
WHITE_KING = "\u2654".encode('utf-8')
WHITE_QUEEN = "\u2655".encode('utf-8')
WHITE_KNIGHT = "\u2658".encode('utf-8')
WHITE_BISHOP = "\u2657".encode('utf-8')
WHITE_PAWN = "\u2659".encode('utf-8')
WHITE_ROOK = "\u2656".encode('utf-8')

class Board

    def initialize
        @board = Array.new(8) { Array.new(8, " ") }
        @board = new_board(@board)
        @white_graveyard = Hash.new
        @black_graveyard = Hash.new
        @white_graveyard.default = 0
        @black_graveyard.default = 0
        @white_turn = true
    end

    def display_board
    end

    private
    def new_board
        #white pieces
        board[0][0], board[7][0] = Rook.new
        board[1][0], board[6][0] = Knight.new
        board[2][0], board[5][0] = Bishop.new
        board[3][0] = Queen.new
        board[4][0] = King.new
        board[0][1], board[1][1],  board[2][1],  board[3][1] = Pawn.new
        board[4][1], board[5][1],  board[6][1],  board[7][1] = Pawn.new

        #black pieces
        board[0][7], board[7][7] = Rook.new(false)
        board[1][7], board[6][7] = Knight.new(false)
        board[2][7], board[5][7] = Bishop.new(false)
        board[3][7] = Queen.new(false)
        board[4][7] = King.new(false)
        board[0][6], board[1][6],  board[2][6],  board[3][6] = Pawn.new(false)
        board[4][6], board[5][6],  board[6][6],  board[7][6] = Pawn.new(false)
    end
end

class King
    def initialize white_piece=true
        white_piece ? @piece = WHITE_KING : @piece = BLACK_KING
    end
end

class Queen
    def initialize white_piece=true
        white_piece ? @piece = WHITE_QUEEN : @piece = BLACK_QUEEN
    end
end

class Knight
    def initialize white_piece=true
        white_piece ? @piece = WHITE_KNIGHT : @piece = BLACK_KNIGHT
    end
end

class Bishop
    def initialize(white_piece=true)
        white_piece ? @piece = WHITE_BISHOP : @piece = BLACK_BISHOP
    end
end

class Rook
    def initialize white_piece=true
        white_piece ? @piece = WHITE_ROOK : @piece = BLACK_BISHOP
    end
end

class Pawn
    def initialize white_piece=true
        white_piece ? @piece = WHITE_PAWN : @piece = BLACK_PAWN
    end
end