class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = 'Book was successfully created.'

    else
      @books = Book.all
      render :index
    end
    #renderを使用してviewファイルを表示したときにはactionを呼び出し処理をしているわけではありません。
    #この場合はindexのページを直接呼び出しているので、createアクションが実行されず、
    #index内のリストと新規作成フォームが作られなくなります。
    #そのため、renderと一緒にリストを読み込むための@booksを定義する必要があります。
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:nice] = 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
