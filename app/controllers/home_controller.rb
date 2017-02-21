class HomeController < ApplicationController

  def index
    if current_user
      @letters = current_user.letters
      @shared_letters = current_user.letters_shared_with_me
    end
  end
end
