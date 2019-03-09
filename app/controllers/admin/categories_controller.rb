class Admin::CategoriesController < AdminController

  def new
    @cat = Category.new
  end

  def create
    @cat =Category.new(cat_params)

    if @cat.save
      flash[:success] = "Successfully Registerd"
      redirect_to admin_categories_url
    else
      render "new"
    end
  end

  def index
    @cats = Category.paginate(page: params[:page], per_page: 20)
  end

  def edit
    @cat = Category.find(params[:id])
  end

  def update
    @cat = Category.find(params[:id])
    
    if @cat.update_attributes(cat_params)
      flash[:success] = "Updated"
      redirect_to admin_categories_url
    else
      render "edit"
    end

  end
  
  def destroy
    cat = Category.find(params[:id])
    cat.destroy
    flash[:warning] = "You deleted : #{cat.title} "
    redirect_to  admin_categories_url
  end

  private
  def cat_params
    params.require(:category).permit(:title, :description)
  end

  

  
end
