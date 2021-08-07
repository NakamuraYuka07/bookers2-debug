class SearchesController < ApplicationController
  def search
      @books = Book.search(params[:search])
  end
  
  def index
      @books = Book.find(params[:id])
  end
end
