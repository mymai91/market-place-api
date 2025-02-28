require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  let(:user) {create(:user, email: 'test@marketplace.com')}
  let(:order) {create(:order, user: user, product_count: 3)}

  describe "send_confirmation" do
    let(:mail) { OrderMailer.send_confirmation(order) }

    it "renders the subject" do
      expect(mail.subject).to eq("Order Confirmation")
    end

    it "sets correct sender email" do
      expect(mail.from).to eq(['no-reply@marketplace.com'])
    end

    it "includes the order ID in the body" do
      expect(mail.body.encoded).to match(order.id.to_s)
    end

    it "includes the number of products in the body" do
      expect(mail.body.encoded).to match(order.products.count.to_s)
    end
  end

end
