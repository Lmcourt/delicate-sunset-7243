require 'rails_helper'

RSpec.describe 'flight index page' do
  before :each do
    @a1 = Airline.create!(name: "Frontier")
    @a2 = Airline.create!(name: "Delta")
    @a3 = Airline.create!(name: "Air France")

    @f1 = @a1.flights.create!(number: 1111, date: "08/03/20", departure_city: "Denver", arrival_city: "Reno")
    @f2 = @a1.flights.create!(number: 2222, date: "08/03/20", departure_city: "Orlando", arrival_city: "London")
    @f3 = @a1.flights.create!(number: 3333, date: "08/03/20", departure_city: "Paris", arrival_city: "Nice")
    @f4 = @a2.flights.create!(number: 4444, date: "08/03/20", departure_city: "Nice", arrival_city: "Paris")
    @f5 = @a3.flights.create!(number: 5555, date: "08/03/20", departure_city: "Another City", arrival_city: "Miami")
    @f6 = @a3.flights.create!(number: 6666, date: "08/03/20", departure_city: "Denver", arrival_city: "Orlando")

    @p1 = Passenger.create!(name: "Joe", age: 2)
    @p2 = Passenger.create!(name: "Michael", age: 30)
    @p3 = Passenger.create!(name: "Tim", age: 32)
    @p4 = Passenger.create!(name: "Kono", age: 24)
    @p5 = Passenger.create!(name: "Selena", age: 12)
    @p6 = Passenger.create!(name: "Gomez", age: 32)
    @p7 = Passenger.create!(name: "Pierre", age: 22)

    FlightPassenger.create!(flight: @f1, passenger: @p1)
    FlightPassenger.create!(flight: @f1, passenger: @p2)
    FlightPassenger.create!(flight: @f1, passenger: @p3)
    FlightPassenger.create!(flight: @f2, passenger: @p2)
    FlightPassenger.create!(flight: @f2, passenger: @p4)
    FlightPassenger.create!(flight: @f3, passenger: @p2)
    FlightPassenger.create!(flight: @f3, passenger: @p3)
    FlightPassenger.create!(flight: @f3, passenger: @p5)
    FlightPassenger.create!(flight: @f6, passenger: @p7)

    visit flights_path
  end

  it 'shows the flight numbers' do

    expect(page).to have_content(@f1.number)
    expect(page).to have_content(@f2.number)
    expect(page).to have_content(@f3.number)
    expect(page).to have_content(@f4.number)
    expect(page).to have_content(@f5.number)
    expect(page).to have_content(@f6.number)
  end

  it 'shows airline next to each flight number' do

    expect(page).to have_content("#{@f1.number}- #{@a1.name}")
    expect(page).to have_content("#{@f4.number}- #{@a2.name}")
    expect(page).to have_content("#{@f6.number}- #{@a3.name}")
  end

  it 'lists all passengers under the flight numbers' do

    within("#flights-#{@f1.id}") do
      # save_and_open_page
      expect(page).to have_content(@p1.name)
      expect(page).to have_content(@p2.name)
      expect(page).to have_content(@p3.name)
    end
  end

  it 'has a button to remove a passenger' do
    # save_and_open_page
    expect(page).to have_content(@f1.number)
    within("#flights-#{@f1.id}") do
      within("#passenger-#{@p1.id}") do
        click_on("Remove Passenger")
      end
      expect(page).to_not have_content(@p1.name)
    end
  end
end
