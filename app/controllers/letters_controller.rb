class LettersController < ApplicationController

  def new
    @letter = Letter.new
  end

  def show
    @letter = current_user.letters.find(params[:id])
  end

  def create
    @letter = current_user.letters.build(letter_params)
    if @letter.save
      redirect_to letter_path(@letter)
    else
      flash[:error] = "Your letter must have content."
      render :new
    end
  end

  private

  def letter_params
    params.require(:letter).permit(:title, :content)
  end
end
