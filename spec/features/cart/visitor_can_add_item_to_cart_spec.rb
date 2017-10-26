require 'rails_helper'

RSpec.describe "Visitor Can Add Items To Cart" do

  let(:store) { Store.create(name: "Knautical Knots", description: "Underwater basket weaving supplies, not just for lazy millenials!", image: "knotical-knots.png") }

  context "they add an item to the cart" do
    it "see that item in their view" do
      category = Category.create(title: "scuba")
      item = category.items.create!(title: "Mask", store: store, description: "This is for your face", price: 10.00, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")

      visit "/categories/#{category.id}"

      expect(page).to have_button("Add to Cart")

      click_button "Add to Cart"
      click_button "Add to Cart"

      find(:css, '.cart').click

      expect(current_path).to eq(cart_path)
      expect(page).to have_css("img[src*='https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg']")
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.description)
      expect(page).to have_content(20.00)
    end
  end
end
