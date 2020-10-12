class Kasey::KaseInboxMailbox < Kasey::ApplicationMailbox
  before_processing :find_case
  def process
    logger.error("CASE_INBOX: kase? #{@kase.inspect}")
    return unless @kase
    @kase.messages.create(body: body, direction: :in)
  end

  private

  def find_case
    logger.error("CASE_INBOX: received mail! #{mail.inspect}")
    # this can be slow, as it's running in a side process that's delivering email
    # check for existence of intake,
    # map intakes
    # match on email
    # nab the ids
    intake_ids = Kasey::Kase.all
      .filter { |k| k.intake }
      .map(&:intake)
      .filter { |i| i.email == main.from.first }
      .map(&:id)
    @kase = Kasey::Kase.find_by(token: extract_token(mail), intake_id: intake_ids)
  end

  def extract_token(msg)
    recipients = mail.to

    # the username value of the first email address
    recipients.first.split('@').first
  end

  def attachments
    @_attachments = mail.attachments.map do |attachment|
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(attachment.body.to_s),
        filename: attachment.filename,
        content_type: attachment.content_type,
      )
      { original: attachment, blob: blob }
    end
  end

  def body
    if mail.multipart?
      if mail.html_part
        html = mail.html_part.body.decoded
      else
        html = "<body><div>#{mail.text_part.body.decoded}</div></body>"
      end
      document = Nokogiri::HTML(html)

      attachments.each do |attachment_hash|
        attachment = attachment_hash[:original]
        blob = attachment_hash[:blob]

        if attachment.content_id.present?
          # Remove the beginning and end < >
          content_id = attachment.content_id[1...-1]
          element = document.at_css "img[src='cid:#{content_id}']"
          action_text = <<~ACTION_TEXT
            <action-text-attachment sgid=\"#{blob.attachable_sgid}\"
                                    content-type=\"#{attachment.content_type}\"
                                    filename=\"#{attachment.filename}\">
            </action-text-attachment>
          ACTION_TEXT
          if element
            element.replace(action_text)
          else
            document.at_css("body").add_child(action_text)
          end
        end
      end
      document.at_css("body").inner_html.encode('utf-8')
    else
      mail.decoded
    end
  end
end
