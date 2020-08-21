class PhonesController < ApplicationController
  before_action :set_phones, only: [:show]

  def show
    render json: @phones
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_phones
    @phones = Contact.find(params[:contact_id]).phones
  end

  # Only allow a trusted parameter "white list" through.
  def kind_params
    params.require(:kind).permit(:description)
  end
end
