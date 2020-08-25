class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    page_number = params[:page].try(:[], :number)
    page_size = params[:page].try(:[], :size)

    @contacts = Contact.all.page(page_number).per(page_size)
    #or only or except #see as_json on model
    #include is not performatic (several selects)
    # render json: @contacts, only: [:id, :name, :email, :birthdate], include: { kind: { only: [:description] } }
    render json: @contacts, include: [:kind, :address, :phone], meta: { author: "Fabio Muller"} #see model
  end

  # GET /contacts/1
  def show
    # render json: @contact, root: true
    render json: @contact, include: [:kind, :address, :phone], meta: { author: "Fabio Muller"}
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact, include: [:kind, :phones]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      # params.require(:contact).permit(:name, :email, :birthdate, :kind_id,
      # phones_attributes: [:id, :number, :_destroy],
      # address_attributes: [:id, :street, :city])
    end
end
