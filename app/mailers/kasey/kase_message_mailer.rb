class Kasey::KaseMessageMailer < ApplicationMailer
  def message_email
    @kase = params[:kase]
    @message = params[:message]
    @message.body.body.attachables.each do |blob|
      attachments[blob.filename.to_s] = {
        mime_type: blob.content_type,
        content: blob.download
      }
    end
    mail(
      to: @kase.intake.email,
      from: "#{@kase.token}@sandboxfd8dce1636144836a50674167a7f71f2.mailgun.org",
    )
  end
end
