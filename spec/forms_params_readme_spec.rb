require 'spec_helper'

describe "App" do
  describe 'GET /food_form' do
    it "can fill in the form" do
      agent = "Carl Jr."
      food = "Vegan Black-Bean Burger"

      visit "/food_form"

      fill_in("name", with: agent)
      fill_in("favorite_food", with: food)

      expect(find_field('name').value).to eq agent
      expect(find_field('favorite_food').value).to eq food
    end
  end

  describe 'POST /food' do
    it 'responds with a 200' do
      post '/food'

      expect(last_response.status).to eq(200)
    end

    it 'displays the params' do
      params = {
        :name => "Carl",
        :favorite_food => "fried chicken"
      }

      post '/food', params

      expect(last_response.body).to eq("My name is #{params[:name]}, and I love #{params[:favorite_food]}")
    end
  end
end