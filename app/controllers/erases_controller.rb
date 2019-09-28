class ErasesController < ApplicationController
  # DELETE /erase
  def destroy
    if Event.clear_all
      render json: {}, status: :ok
    else
      render json: {}, status: :internal_error
    end
  end
end
