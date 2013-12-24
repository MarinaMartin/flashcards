class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :increment, :decrement]
  before_filter :authenticate_user!

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @cards = Card.where(:category_id => @card.category_id)
    @random = Card.random_weighted(:weight)
  end
  
  def random
    @random = Card.random_weighted(:weight)
    redirect_to @random
  end
  
  def increment
    @random = Card.random_weighted(:weight)
    @card.increment!(:weight)
    redirect_to @random
  end
  
  def decrement
    @random = Card.random_weighted(:weight)
    @card.decrement!(:weight)
    redirect_to @random
  end
  
  # GET /cards/new
  def new
    @card = Card.new
    @categories = Category.all
  end

  # GET /cards/1/edit
  def edit
    @categories = Category.all
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render action: 'show', status: :created, location: @card }
      else
        format.html { render action: 'new' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:front, :back, :mnemonic, :category_id, :memorized, :weight)
    end
end
