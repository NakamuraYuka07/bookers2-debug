class BooksController < ApplicationController

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @comment = Comment.new
  end

  def index
    @book_new = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @books = Book.all
    @book_new = Book.new(book_params)
    @user = current_user
    @book_new.user_id = current_user.id
    if @book_new.save
      redirect_to book_path(@book_new), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id  != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def search
    method = params[:search_method]
    word = params[:keyword]
    @books = Book.search(method,word)
  end

  private
  def book_params
    params.permit(:title, :body,)
  end
end
