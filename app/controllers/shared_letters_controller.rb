class SharedLettersController < ApplicationController
  def create
    user = User.find_by(email: params[:recipients])
    letter = Letter.find(params[:letter_id])
    SharedLetter.create(letter: letter, user: user)
    if user
      flash[:success] = "You shared #{letter.title} with #{user.email}"
      redirect_to letter_path(letter)
    else
      flash[:error] = "This user doesn't exist."
    end
  end
end
