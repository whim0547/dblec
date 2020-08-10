class ItemsController < ApplicationController
  include SessionsHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy, :borrow_item, :return_item]


  # GET /items
  # GET /items.json
  def index
    @items = Item.where(group_id: current_user.group_id).paginate(page: params[:page])
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.group = current_user.group
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.group = current_user.group

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def borrow_item
    @item.update(is_borrow: true, user: current_user)
    redirect_to request.referrer || root_url
    # respond_to do |format|
    #   format.html { redirect_to items_url, notice: 'Item was successfully borrowed.' }
    #   format.json { head :no_content }
    # end
  end

  def return_item
    if @item.user = current_user
      @item.update(is_borrow: false)
      redirect_to request.referrer || root_url
      # respond_to do |format|
      #   format.html { redirect_to items_url, notice: 'Item was successfully returned.' }
      #   format.json { head :no_content }
      # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :user_id, :is_borrow, :note)
    end
end
