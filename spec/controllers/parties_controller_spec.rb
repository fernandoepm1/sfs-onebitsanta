require 'rails_helper'

RSpec.describe PartiesController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        @party_attr = attributes_for(:party, user: @current_user)
        post :create, params: { party: @party_attr }
      end

      it 'redirects to new party' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/partys/#{party.last.id}")
      end

      it 'creates party with valid attributes' do
        party = party.last
        expect(party.user).to eql(@current_user)
        expect(party.title).to eql(@party_attr[:title])
        expect(party.description).to eql(@party_attr[:description])
        expect(party.status).to eql('pending')
      end

      it 'associates organizer as a member' do
        party = party.last
        expect(party.members.last.name).to eql(@current_user.name)
        expect(party.members.last.email).to eql(@current_user.email)
      end
    end

    context 'with invalid attributes' do
    end
  end

  describe 'GET #show' do
    context 'when party exists' do
      context 'and user is the current organizer' do
        it 'returns http success' do
          party = create(:party, user: @current_user)
          get :show, params: { id: party.id }
          expect(response).to have_http_status(:success)
        end
      end

      context 'and user is not the current organizer' do
        it 'redirects to root' do
          party = create(:party)
          get :show, params: { id: party.id }
          expect(response).to redirect_to('/')
        end
      end
    end

    context 'when party does not exist' do
      it 'redirects to root' do
        get :show, params: { id: 0 }
        expect(response).to redirect_to('/')
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      request.env['HTTP_ACCEPT'] = 'application/json'
      @new_party_attr = attributes_for(:party)
    end

    context 'user is the current organizer' do
      it 'returns http success' do
        party = create(:party, user: @current_user)
        put :update, params: { id: party.id, party: @new_party_attr }
        expect(response).to have_http_status(:success)
      end

      it 'updates party with new attributes' do
        party = party.last
        expect(party.title).to eql(@new_party_attr[:title])
        expect(party.description).to eql(@new_party_attr[:description])
      end
    end

    context 'user is not the current organizer' do
      it 'returns http forbidden' do
        party = create(:party)
        put :update, params: { id: party.id, party: @new_party_attr }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'when user is the current organizer' do
      it 'returns http success' do
        party = create(:party, user: @current_user)
        get :destroy, params: { id: party.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not the current organizer' do
      it 'return http forbidden' do
        party = create(:party)
        get :destroy, params: { id: party.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST #raffle' do
    before(:each) do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'user is the current organizer' do
      before(:each) do
        @party = create(:party, user: @current_user)
      end

      context 'and party has more than 2 members' do
        before(:each) do
          create(:member, party: @party)
          create(:member, party: @party)
        end

        it 'returns http success' do
          post :raffle, params: { id: @party.id }
          expect(response).to have_http_status(:success)
        end
      end

      context 'and party has only two members' do
        before(:each) do
          create(:member, party: @party.id)
        end

        it 'returns http unprocessable_entity' do
          post :raffle, params: { id: @party.id }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'user is not the current organizer' do
      before(:each) do
        @party = create(:party)
        create(:member, party: @party)
      end

      it 'returns http forbidden' do
        post :raffle, params: { id: @party.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
