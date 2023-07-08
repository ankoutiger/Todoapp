class BoardsController < ApplicationController
    def new
        @board = Board.new
    end

    def create
        @board = Board.create(board)
    end
end