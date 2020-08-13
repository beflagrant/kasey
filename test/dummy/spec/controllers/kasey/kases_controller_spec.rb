require 'rails_helper'
require 'pry'

RSpec.describe Kasey::KasesController, type: :controller do
  routes { Kasey::Engine.routes }
  render_views

  context 'when the user is authorized' do
    let(:admin) { User.find(2) || create(:admin) }

    login_admin

    before do
    end

    context '#index' do
      let!(:kases) do
        (1..4).map { create(:kase) }
      end

      before do
        allow(controller).to receive(:has_access?).and_return(true)
      end

      it 'displays a list of cases' do
        get :index

        expect(response).to have_http_status(200)
        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end
      end

      it 'does not display closed cases' do
        closed_kase =  create(:kase, aasm_state: :closed)
        get :index

        expect(response).to have_http_status(200)
        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end

        expect(response.body).not_to have_content(closed_kase.intake.email)
      end

      pending 'displayes only the cases the user has acess to'

      it 'displays only the cases the user has access to' do
        authz_kase1 = create(:kase)
        authz_kase2 = create(:kase)

        kases.each do |kase|
          expect(controller).to receive(:has_access?)
            .with(admin, kase)
            .and_return(false)
        end
        expect(controller).to receive(:has_access?)
          .with(admin, authz_kase1)
          .and_return(true)
        expect(controller).to receive(:has_access?)
          .with(admin, authz_kase2)
          .and_return(true)

        get :index

        expect(response).to have_http_status(200)
        expect(response.body).to have_content(authz_kase1.intake.email)
        expect(response.body).to have_content(authz_kase2.intake.email)
        kases.each do |kase|
          expect(response.body).not_to have_content(kase.intake.email)
        end

      end

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
