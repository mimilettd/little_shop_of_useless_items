require 'rails_helper'

RSpec.describe "As an admin" do

  let(:store) { Store.create(name: "Knautical Knots", description: "Underwater basket weaving supplies, not just for lazy millenials!", image: "knotical-knots.png") }
  describe "I visit the admin dashboard" do
    xit "I see listing of all orders" do
      user = User.create(first_name: "Bon", last_name: "Jovi", address: "123 crazy street", email: "deadoralive@awesome.com", username: "bonjovirules", password: "deadoralive", platform_admin: true)
      user_2 = User.create(first_name: "Sponge", last_name: "Bob", address: "123 crazy street", email: "deadoralive@awesome.com", username: "sponge", password: "bob")

      category_1 = Category.create(title: "scuba")
      category_2 = Category.create(title: "basket")

      item_1 = Item.create(title: "Mask", store: store, description: "Something to put on your face.", price: 49.95, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")
      item_2 = Item.create(title: "Fins", store: store, description: "Something to put on your feet.", price: 69.95, image: "http://www.scuba-info.com/images/scuba_gear_fins.jpg")
      item_3 = Item.create(title: "Basket Weaving Reed", store: store, description: "Something to weave your basket", price: 5.00, image: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSmgQUfZjdClyn6CqS_Sc_eTm8zLe_bgG4RUnq-sbV2x6LyM1dD9ESyJdGf9AbdnKNYxe2wbRY&usqp=CAE")
      item_4 = Item.create(title: "10 in Basket Base", store: store, description: "Something to base your basket on", price: 9.99, image: "https://files.slack.com/files-pri/T029P2S9M-F731BU32S/base-300x300.jpg")

      ItemCategory.create(item_id: item_1, category_id: category_1)
      ItemCategory.create(item_id: item_2, category_id: category_1)
      ItemCategory.create(item_id: item_3, category_id: category_2)
      ItemCategory.create(item_id: item_4, category_id: category_2)

      order_1 = Order.create(user_id: 1, status: 1, total_price: 154.85)
      order_2 = Order.create(user_id: 2, status: 2, total_price: 149.89)

      OrderItem.create(order_id: order_1, item_id: item_1, quantity: 3)
      OrderItem.create(order_id: order_1, item_id: item_3, quantity: 1)
      OrderItem.create(order_id: order_2, item_id: item_2, quantity: 2)
      OrderItem.create(order_id: order_2, item_id: item_4, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path

      expect(page).to have_content("Bon Jovi")
      expect(page).to have_content("Paid")
      expect(page).to have_content("Sponge Bob")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("Ordered")
      expect(page).to have_content("1")
    end

    xit "can be sorted by status" do
      admin = User.create(first_name: "Bon", last_name: "Jovi", address: "123 crazy street", email: "deadoralive@awesome.com", username: "bonjovirules", password: "deadoralive", platform_admin: true)
      category = Category.create(title: "scuba")
      item_1 = category.items.create!(title: "Mask", store: store, description: "This is for your face", price: 10.00, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")
      item_2 = category.items.create!(title: "Tank", store: store, description: "This is for your face", price: 10.00, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit items_path

      within(".item-#{item_1.id}") do
        find(:css, ".add-to-cart").click
      end

      within(".item-#{item_1.id}") do
        find(:css, ".add-to-cart").click
      end

      within(".item-#{item_2.id}") do
        find(:css, ".add-to-cart").click
      end

      find(:css, ".cart").click

      click_button "Checkout"

      visit admin_dashboard_path

      click_on "Ordered"

      expect(page).to have_content("Bon Jovi")
      expect(page).to have_no_content("Sponge Bob")
      expect(page).to have_content("Paid")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("Completed")
    end

    xit "can change status of orders" do
      user = User.create!(first_name: "Bon", last_name: "Jovi", address: "123 crazy street", email: "deadoralive@awesome.com", username: "bonjovirules", password: "deadoralive", platform_admin: true)
      user_2 = User.create!(first_name: "Sponge", last_name: "Bob", address: "123 crazy street", email: "deadoralive@awesome.com", username: "sponge", password: "bob")

      category_1 = Category.create!(name: "scuba")
      category_2 = Category.create!(name: "basket")

      item_1 = Item.create!(title: "Mask", store: store, description: "Something to put on your face.", price: 49.95, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")
      item_2 = Item.create!(title: "Fins", store: store, description: "Something to put on your feet.", price: 69.95, image: "http://www.scuba-info.com/images/scuba_gear_fins.jpg")
      item_3 = Item.create!(title: "Basket Weaving Reed", store: store, description: "Something to weave your basket", price: 5.00, image: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSmgQUfZjdClyn6CqS_Sc_eTm8zLe_bgG4RUnq-sbV2x6LyM1dD9ESyJdGf9AbdnKNYxe2wbRY&usqp=CAE")
      item_4 = Item.create!(title: "10 in Basket Base", store: store, description: "Something to base your basket on", price: 9.99, image: "https://files.slack.com/files-pri/T029P2S9M-F731BU32S/base-300x300.jpg")

      ItemCategory.create!(item_id: item_1.id, category_id: category_1.id)
      ItemCategory.create!(item_id: item_2.id, category_id: category_1.id)
      ItemCategory.create!(item_id: item_3.id, category_id: category_2.id)
      ItemCategory.create!(item_id: item_4.id, category_id: category_2.id)

      order_1 = Order.create!(user_id: user_2.id, status: 1, total_price: 154.85)

      OrderItem.create!(order_id: order_1.id, item_id: item_1.id, quantity: 3)
      OrderItem.create!(order_id: order_1.id, item_id: item_3.id, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path
      click_button("Completed")

      click_on("4")
      expect(page).to have_content("completed")
    end

    xit "can cancel orders" do
      user = User.create(first_name: "Bon", last_name: "Jovi", address: "123 crazy street", email: "deadoralive@awesome.com", username: "bonjovirules", password: "deadoralive", platform_admin: true)
      user_2 = User.create(first_name: "Sponge", last_name: "Bob", address: "123 crazy street", email: "deadoralive@awesome.com", username: "sponge", password: "bob")

      category_1 = Category.create!(name: "scuba")
      category_2 = Category.create!(name: "basket")

      item_1 = Item.create!(title: "Mask", store: store, description: "Something to put on your face.", price: 49.95, image: "https://slack-imgs.com/?c=1&url=http%3A%2F%2Fwww.scubadivingdreams.com%2Fwp-content%2Fuploads%2F2015%2F11%2Fthe-best-scuba-snorkel-mask-mares-i3-sunrise.jpg")
      item_2 = Item.create!(title: "Fins", store: store, description: "Something to put on your feet.", price: 69.95, image: "http://www.scuba-info.com/images/scuba_gear_fins.jpg")
      item_3 = Item.create!(title: "Basket Weaving Reed", store: store, description: "Something to weave your basket", price: 5.00, image: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSmgQUfZjdClyn6CqS_Sc_eTm8zLe_bgG4RUnq-sbV2x6LyM1dD9ESyJdGf9AbdnKNYxe2wbRY&usqp=CAE")
      item_4 = Item.create!(title: "10 in Basket Base", store: store, description: "Something to base your basket on", price: 9.99, image: "https://files.slack.com/files-pri/T029P2S9M-F731BU32S/base-300x300.jpg")

      ItemCategory.create!(item_id: item_1.id, category_id: category_1.id)
      ItemCategory.create!(item_id: item_2.id, category_id: category_1.id)
      ItemCategory.create!(item_id: item_3.id, category_id: category_2.id)
      ItemCategory.create!(item_id: item_4.id, category_id: category_2.id)

      order_1 = Order.create!(user_id: user.id, status: 1, total_price: 154.85)

      OrderItem.create!(order_id: order_1.id, item_id: item_1.id, quantity: 3)
      OrderItem.create!(order_id: order_1.id, item_id: item_3.id, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path
      click_button "Cancel"

      click_on "5"
      expect(page).to have_content("cancelled")
    end
  end
end
