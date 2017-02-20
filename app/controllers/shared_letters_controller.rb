class SharedLettersController < ApplicationController
  def create
    user = User.find_by(email: params[:recipients])
    letter = Letter.find(params[:letter_id])
    if user
      SharedLetter.create(letter: letter, user: user)
      flash[:success] = "You shared #{letter.title} with #{user.email}"
      redirect_to letter_path(letter)
    else
      flash[:error] = "This user doesn't exist."
      redirect_to letter_path(letter)
    end
  end
end
