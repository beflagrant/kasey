class Kasey::MessagesController < Kasey::ApplicationController
  before_action :set_kase
  before_action :set_message, only: [:edit, :update]

  def edit; end

  def create
    @message = @kase.messages.new(message_params)
    @message.sent_by = authenticated_user || 'Kasey'
    respond_to do |format|
      if @message.save
        if @message.out?
          @kase.respond!
          Kasey::KaseMessageMailer.with(kase: @kase, message: @message)
            .message_email.deliver_later
        end

        format.html { redirect_to @kase, notice: 'Message was successfully added.' }
        # format.json { render :show, status: :ok, location: @admin_case }
      else
        format.html { render :edit }
        # format.json { render json: @admin_case.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # TODO: messages are not editable unless they are internal
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @admin_case, notice: 'Message was successfully updated.' }
        # format.json { render :show, status: :ok, location: @admin_case }
      else
        format.html { render :edit }
        # format.json { render json: @admin_case.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_kase
    @kase = Kasey::Kase.find(params[:kase_id])
  end

  def set_message
    @message = Kasey::Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:body, :case_id, :direction)
  end
end
