require 'rails_helper'

RSpec.describe Kasey::KaseInboxMailbox, type: :mailbox do
  let(:email) { 'from-address@kasey.example.com' }
  let(:intake) { create(:intake, email: email) }
  let(:kase) { intake.kase }
  let(:other_case) { create(:intake).kase }

  context 'from an email address with an active case' do
    context 'to a case address matching their case token' do
      subject do
        receive_inbound_email_from_mail(
          from: email,
          to: "#{kase.token}@kasey.example.com",
          subject: 'test case',
          body: 'this is a message from the client'
        )
      end

      it do
        expect { subject }.to change(Kasey::Message, :count).by(1)
      end
    end

    context 'to a case address not matching their case' do
      subject do
        receive_inbound_email_from_mail(
          from: 'from-address@kasey.example.com',
          to: "#{other_case.token}@kasey.example.com",
          subject: 'test case',
          body: "this is a message from a scammer"
        )
      end

      it do
        expect { subject }.not_to change(Kasey::Message, :count)
      end
    end
  end
end
