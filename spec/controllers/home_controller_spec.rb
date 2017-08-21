require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  # Get #index
  describe 'GET #index' do

    it 'assigns @last_results' do
			get :index
			expect(assigns(:last_results)).to_not be_nil
		end

		it 'renders the :index view' do
			get :index
			expect(response).to render_template(:index)
		end
	end
	# Get #new
	describe 'GET #new' do
		
		it 'renders the :new view' do
			get :new
			expect(response).to render_template(:new)
		end
	end

end
