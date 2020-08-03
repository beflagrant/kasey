require_dependency "kasey/application_controller"

module Kasey
  class KasesController < ApplicationController
    before_action :set_kase, only: [:show, :edit, :update, :destroy]

    # GET /kasey/kases
    # GET /kasey/kases.json
    def index
      @kases = Kase.where.not(aasm_state: 'closed')
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

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_kase
      @kase = Kase.find(params[:id])
    end

    def kase_params
      params.fetch(:kase, {})
    end
  end
end
