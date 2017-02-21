class LettersController < ApplicationController
  before_action :require_login, only: [:new, :show, :create, :index]

  def index
    @letters = current_user.letters
    @shared_letters = current_user.letters_shared_with_me
  end

  def new
    @letter = Letter.new
  end

  def show
    @letter = current_user.letters.find_by(id: id) ||
      current_user.letters_shared_with_me.find(id)
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

  def id
    params[:id]
  end
end
