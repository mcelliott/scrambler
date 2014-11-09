class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  respond_to :html, :js

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.categories.order(name: :asc)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = current_user.categories.build(category_params)
    flash[:notice] = 'Category was successfully created.' if @category.save
  end

  def update
    flash[:notice] = 'Category was successfully updated.' if @category.update(category_params)
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:name)
  end
end
