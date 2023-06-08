require_dependency "kasey/application_controller"

module Kasey
  class KasesController < ApplicationController
    before_action :authenticate!
    before_action :set_kase, only: [:show, :edit, :update, :destroy]

    def index
      @kases = Kase.where.not(aasm_state: 'closed').order(:created_at).filter do |kase|
        has_access?(authenticated_user, kase)
      end
    end

    def show
      @kase.review! if @kase.open?
    end

    def destroy
      @kase.close!
      respond_to do |format|
        format.html { redirect_to kases_url, notice: 'Kase closed!' }
        format.json { head :no_content }
      end
    end

    def closed
      @kases = Kase.where(aasm_state: 'closed').order(:created_at).filter do |kase|
        has_access?(authenticated_user, kase)
      end
      render :index
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_kase
      @kase = Kase.find(params[:id])
      raise ActiveRecord::RecordNotFound.new('Not Found') unless has_access?(authenticated_user, @kase)
    end

    def kase_params
      params.fetch(:kase, {})
    end
  end
end
