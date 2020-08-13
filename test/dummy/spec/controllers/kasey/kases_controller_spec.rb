require 'rails_helper'
require 'pry'

RSpec.describe Kasey::KasesController, type: :controller do
  routes { Kasey::Engine.routes }
  render_views

  context 'when the user is authorized' do
    let(:admin) { User.find(2) || create(:admin) }

    login_admin

    context '#index' do
      before do
        allow(controller).to receive(:has_access?).and_return(false)
      end

      it 'assigns a list of kases' do
        kases = (1..2).map { create(:intake).kase }
        kases.each do |kase|
          expect(controller).to receive(:has_access?)
            .with(admin, kase)
            .and_return(true)
        end

        get :index

        expect(response).to have_http_status(200)
        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end
      end

      it 'does not display closed cases' do
        kases = (1..2).map { create(:intake).kase }
        intake =  create(:intake)
        closed_kase = intake.kase
        closed_kase.review!
        closed_kase.close!

        kases.each do |kase|
          expect(controller).to receive(:has_access?)
            .with(admin, kase)
            .and_return(true)
        end

        get :index

        expect(response).to have_http_status(200)
        kases.each do |kase|
          expect(response.body).to have_content(kase.intake.email)
          expect(response.body).to have_content(kase.created_at)
        end

        expect(response.body).not_to have_content(closed_kase.intake.email)
      end

      it 'displays only the cases the user has access to' do
        kases = (1..2).map { create(:intake).kase }
        authzed_kase = create(:intake).kase

        kases.each do |kase|
          expect(controller).to receive(:has_access?)
            .with(admin, kase)
            .and_return(false)
        end

        expect(controller).to receive(:has_access?)
          .with(admin, authzed_kase)
          .and_return(true)

        get :index

        expect(response).to have_http_status(200)
        expect(response.body).to have_content(authzed_kase.intake.email)
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
