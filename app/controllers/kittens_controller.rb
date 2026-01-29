class KittensController < ApplicationController
  before_action :set_kitten, only: %i[ show edit update destroy ]
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.xml { render xml:  @kittens }
      format.json  { render json: @kittens }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml { render xml:  @kitten }
      format.json  { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
  end

  def create
    @kitten = Kitten.build(kitten_params)
    if @kitten.save
       flash[:success] = "Great! Your Kitten has been created!"
      redirect_to @kitten
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @kitten.update(kitten_params)
      flash[:success] = "Kitten updated sucessfully!!!"
      redirect_to @kitten
    else
      flash.now[:error] = "Kitten refuses to change!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @kitten.destroy
      flash[:success] = "RIP KITTEN"
      redirect_to kittens_path
    else
      flash.now[:error] = "Kitten won't go away!"
      render :show, status: :unprocessable_entity
    end
  end

  private

  def id_params
    params.expect(:id)
  end

  def kitten_params
    params.expect(kitten: [ :name, :age, :cuteness, :softness ])
  end

  def set_kitten
    @kitten = Kitten.find(id_params)
  end
end
