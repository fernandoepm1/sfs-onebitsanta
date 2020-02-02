require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  describe "GET #create" do
    context 'with valid attributes' do
      it 'creates a new member in the database' do
      end

      it 'creates a new member with the given attributes' do
        
      end

      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new member' do
        
      end
    end
  end

  describe "GET #update" do
    context 'with valid attributes' do
      it 'updates a given member' do
        
      end

      it 'updates the member with given attributes' do
        
      end
      
      it "returns http success" do
        get :update
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      it 'does not update given member' do
        
      end
    end
  end

  describe "GET #destroy" do
    context 'when current user is not the organizer' do
      it 'does not delete member' do
        
      end

      it 'returns http forbidden' do
        get :destroy
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when current user is the organizer' do
      it "returns http success" do
        get :destroy
        expect(response).to have_http_status(:success)
      end
    end
  end
end
