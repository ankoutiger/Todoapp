class TasksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:board_id])
        @comments = @task.comments
    end

    def update
        board = Board.find(params[:id])
        @task = board.tasks.find(params[:board_id])
        if @task.update(tasks_params)
            redirect_to board_task_path(@task), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def edit
        board = Board.find(params[:id])
        @task = board.tasks.find(params[:board_id])
    end

    def new
        board = Board.find(params[:board_id])
        @task = board.tasks.build(user_id: current_user.id)
    end

    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(tasks_params)
        @task.user_id = current_user.id
        if @task.save
            redirect_to board_path(board), notice: 'タスクを追加しました'
        else
            flash.now[:error] = '更新できませんでした。'
            render :new
        end
    end

    def destroy
        board = Board.find(params[:id])
        task = board.tasks.find(params[:board_id])
        task.destroy!
        redirect_to root_path, notice: '削除できました！'
    end

    private
    def tasks_params
        params.require(:task).permit(:title, :content, :date, :eyecatch)
    end
end
