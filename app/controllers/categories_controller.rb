class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(title: params[:category][:title])
    respond_to do |format|
      if @category.save
        format.js   { render :create_success }
      else
        format.js { render :create_fail }
      end
    end
  end

  def edit
    find_category
    respond_to do |format|
      format.js {render :edit}
    end
  end


  def update
    find_category
    @category.title = params[:category][:title]
    respond_to do |format|
      if @category.save
        format.js {render :update_success }
      else
        format.js {render :update_fail}
      end
    end
  end

  def destroy
    find_category
    @category.destroy
    respond_to do |format|
      format.js { render }
    end
  end


private

def find_category
  @category = Category.find params[:id]
end




end
