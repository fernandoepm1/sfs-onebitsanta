require 'rails_helper'

RSpec.describe GatheringsController, type: :controller do
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
        @gathering_attr = attributes_for(:gathering, user: @current_user)
        post :create, params: { gathering: @gathering_attr }
      end

      it 'redirects to new gathering' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/gatherings/#{Gathering.last.id}")
      end

      it 'creates gathering with valid attributes' do
        gathering = Gathering.last
        expect(gathering.user).to eql(@current_user)
        expect(gathering.title).to eql(@gathering_attr[:title])
        expect(gathering.description).to eql(@gathering_attr[:description])
        expect(gathering.status).to eql('pending')
      end

      it 'associates organizer as a member' do
        gathering = Gathering.last
        expect(gathering.members.last.name).to eql(@current_user.name)
        expect(gathering.members.last.email).to eql(@current_user.email)
      end
    end

    context 'with invalid attributes' do
    end
  end

  describe 'GET #show' do
    context 'when gathering exists' do
      context 'and user is the current organizer' do
        it 'returns http success' do
          gathering = create(:gathering, user: @current_user)
          get :show, params: { id: gathering.id }
          expect(response).to have_http_status(:success)
        end
      end

      context 'and user is not the current organizer' do
        it 'redirects to root' do
          gathering = create(:gathering)
          get :show, params: { id: gathering.id }
          expect(response).to redirect_to('/')
        end
      end
    end

    context 'when gathering does not exist' do
      it 'redirects to root' do
        get :show, params: { id: 0 }
        expect(response).to redirect_to('/')
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      request.env['HTTP_ACCEPT'] = 'application/json'
      @new_gathering_attr = attributes_for(:gathering)
    end

    context 'user is the current organizer' do
      it 'returns http success' do
        gathering = create(:gathering, user: @current_user)
        put :update, params: { id: gathering.id, gathering: @new_gathering_attr }
        expect(response).to have_http_status(:success)
      end

      it 'updates gathering with new attributes' do
        gathering = Gathering.last
        expect(gathering.title).to eql(@new_gathering_attr[:title])
        expect(gathering.description).to eql(@new_gathering_attr[:description])
      end
    end

    context 'user is not the current organizer' do
      it 'returns http forbidden' do
        gathering = create(:gathering)
        put :update, params: { id: gathering.id, gathering: @new_gathering_attr }
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
        gathering = create(:gathering, user: @current_user)
        get :destroy, params: { id: gathering.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not the current organizer' do
      it 'return http forbidden' do
        gathering = create(:gathering)
        get :destroy, params: { id: gathering.id }
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
        @gathering = create(:gathering, user: @current_user)
      end

      context 'and gathering has more than 2 members' do
        before(:each) do
          create(:member, gathering: @gathering)
          create(:member, gathering: @gathering)
        end

        it 'returns http success' do
          post :raffle, params: { id: @gathering.id }
          expect(response).to have_http_status(:success)
        end
      end

      context 'and gathering has only two members' do
        before(:each) do
          create(:member, gathering: @gathering.id)
        end

        it 'returns http unprocessable_entity' do
          post :raffle, params: { id: @gathering.id }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'user is not the current organizer' do
      before(:each) do
        @gathering = create(:gathering)
        create(:member, gathering: @gathering)
      end

      it 'returns http forbidden' do
        post :raffle, params: { id: @gathering.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
