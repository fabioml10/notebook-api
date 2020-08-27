require 'rails_helper'

describe ContactsController, type: :controller do
  it 'request index and return is 200 OK' do
    request.accept = "application/vnd.api+json"
    get :index
    expect(response).to have_http_status(:ok)
  end

  it 'request index and return is 406 Not Acceptable' do
    get :index
    expect(response).to have_http_status(:not_acceptable)
  end

  it 'GET show /contacts/:id' do
    request.accept = "application/vnd.api+json"
    contact = Contact.first
    get :show, params: {id: contact.id}
    response_body = JSON.parse(response.body)
    expect(response_body.fetch('data').fetch('id')).to eq(contact.id.to_s)
  end
end
