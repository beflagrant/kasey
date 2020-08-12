require 'rails_helper'
require 'pry'

RSpec.describe Kasey::KasesController, type: :controller do
  routes { Kasey::Engine.routes }
  render_views

  context 'when the user is authorized' do
    login_admin
    context '#index' do
      let!(:kases) do
        (1..4).map { create(:kase) }
      end

      it 'displays a list of cases' do
        get :index

        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end
      end

      it 'does not display closed cases' do
        closed_kase =  create(:kase, aasm_state: :closed)
        get :index

        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end

        expect(response.body).not_to have_content(closed_kase.intake.email)
      end

      pending 'displayes only the cases the user has acess to'
    end


  end

  context 'when no user is signed in' do
    # NOTE! this only applies to the dummy app for reference and to ensure the
    # dummy is behaving.

    it 'redirects to the sign-in path' do
      get :index

      expect(response).to have_http_status(302)
    end
  end
end
