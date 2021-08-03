class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @books = Book.find(params[:book_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      render "books/show"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @comment = current_user.comments.find_by(book_id: @book.id)
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
