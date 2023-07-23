class CommentsController<ApplicationController
    before_action :authenticate_user!

    def new
        # board = Board.find(params[:board_id])
        task = Task.find(params[:task_id])
        @comment = task.comments.build(user_id: current_user.id)
    end

    def create
        # board = Board.find(params[:board_id])
        # @task = board.tasks.find(params[:id])
        task = Task.find(params[:task_id])
        @comment = task.comments.build(comments_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to root_path, notice: 'コメントを追加しました！'
        else
            flash.now[:error] = '更新できませんでした.'
            render :new
        end
    end

    private
    def comments_params
        params.require(:comment).permit(:content)
    end
end