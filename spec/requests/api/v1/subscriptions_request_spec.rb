require 'rails_helper'

describe "Subscriptions API" do
  it "sends a list of a user's subscriptions" do
    user = User.create!(first_name: "Kelly", last_name: "Anderson", address: "1234 Laurel St", email: "kelly@gmail.com")
    tea1 = Tea.create!(title: "Green Tea", description: "Green Tea", temperature: "100", brew_time: "4 minutes")
    tea2 = Tea.create!(title: "Black Tea", description: "Black Tea", temperature: "150", brew_time: "7 minutes")
    tea3 = Tea.create!(title: "White Tea", description: "White Tea", temperature: "200", brew_time: "2 minutes")
    subscription1 = user.subscriptions.create!(title: "my first subscription", price: "55", status: "Active", frequency: "Weekly", teas: [tea1, tea2])
    subscription1 = user.subscriptions.create!(title: "my cancelled subscription", price: "75", status: "Cancelled", frequency: "Weekly", teas: [tea2, tea3])

    params = {"id": "#{user.id}"}
    get '/api/v1/subscriptions', params: params

    subscriptions = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(subscriptions).to have_key(:data)
    expect(subscriptions[:data]).to be_a(Array)
    expect(subscriptions[:data][0]).to have_key(:attributes)
    expect(subscriptions[:data][0][:attributes][:title]).to eq("my first subscription")
    expect(subscriptions[:data][0][:attributes][:teas]).to be_a(Array)
    expect(subscriptions[:data][0][:attributes][:teas][0][:title]).to eq("Green Tea")
  end
end
