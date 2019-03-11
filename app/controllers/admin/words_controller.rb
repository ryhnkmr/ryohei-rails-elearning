class Admin::WordsController < AdminController 

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build

    3.times do
      @choices = @word.choices.build
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(word_params)

    if @word.save 
      flash[:success] = "successfully Registerd"
      redirect_to admin_category_words_url(word_params)
    else
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @word = @category.words.find(params[:id])
    
  end

  def update
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
    
    if @word.update_attributes(word_params)
      
      flash[:success] = "successfully Updated"
      redirect_to admin_category_words_url
    else
      render "edit"
    end
  end

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words.paginate(page: params[:page], per_page: 20)
  end

  def destroy
    word = Word.find(params[:id])
    word.destroy
    flash[:warning] = "You deleted: #{}"
    redirect_to admin_category_words_url
  end

  private
    def word_params
      params.require(:word).permit(:content, choices_attributes: [:id, :content, :correct])
    end

end
