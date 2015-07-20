require 'spec_helper'
require 'support/secrets'
describe ACTransitRails do

  context 'get_ helper methods' do

    before do
      ACTransitRails.configure(Secrets.ACTRANSIT_TOKEN)
    end

    describe '.get_all_routes' do
      before do
        @response = ACTransitRails.get_all_routes
      end

      it 'returns an array of hashes' do
        expect(@response.class).to eq(Array)
        @response.each do |response_hash|
          expect(response_hash.class). to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response.each do |response_hash|
          expect(response_hash).to have_key("RouteId")
          expect(response_hash).to have_key("Name")
          expect(response_hash).to have_key("Description")
        end
      end
    end # describe .get_all_routes

    describe '.get_route' do
      before do
        @response = ACTransitRails.get_route('E')
      end

      it 'returns a hash' do
        expect(@response.class).to eq(Hash)
      end

      it 'should provide a hash with proper keys' do
        expect(@response).to have_key("RouteId")
        expect(@response).to have_key("Name")
        expect(@response).to have_key("Description")
      end
    end # describe .get_route

    describe '.get_trips' do
      before do
        @response = ACTransitRails.get_trips('E')
      end

      it 'returns an array of hashes' do
        expect(@response.class).to eq(Array)
        @response.each do |response_hash|
          expect(response_hash.class). to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response.each do |response_hash|
          expect(response_hash).to have_key("TripId")
          expect(response_hash).to have_key("RouteName")
          expect(response_hash).to have_key("ScheduleType")
          expect(response_hash).to have_key("StartTime")
          expect(response_hash).to have_key("Direction")
        end
      end
    end # describe .get_trips

    describe '.get_directions' do
      before do
        @response = ACTransitRails.get_directions('E')
      end

      it 'should return an array of strings' do
        expect(@response.class).to eq(Array)
        @response.each do |response_string|
          expect(response_string.class).to eq(String)
        end
      end

      it 'should return an array of length 2' do
        expect(@response.count).to eq(2)
      end
    end # describe .get_directions

    describe '.get_stops' do

      before do
        @response_without_trip = ACTransitRails.get_stops('E')
        @response_with_trip = ACTransitRails.get_stops('E', 4119214)
      end

      it 'returns an array of hashes' do
        expect(@response_without_trip.class).to eq(Array)
        expect(@response_with_trip.class).to eq(Array)
        @response_without_trip.each do |response_hash|
          expect(response_hash.class). to eq(Hash)
        end
        @response_with_trip.each do |response_hash|
          expect(response_hash.class). to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response_without_trip.each do |response_hash|
          expect(response_hash).to have_key("StopId")
          expect(response_hash).to have_key("Name")
          expect(response_hash).to have_key("Latitude")
          expect(response_hash).to have_key("Longitude")
          expect(response_hash).to have_key("ScheduledTime")
        end
        @response_with_trip.each do |response_hash|
          expect(response_hash).to have_key("StopId")
          expect(response_hash).to have_key("Name")
          expect(response_hash).to have_key("Latitude")
          expect(response_hash).to have_key("Longitude")
          expect(response_hash).to have_key("ScheduledTime")
        end
      end
    end# describe .get_stops
  end # context get_ helper methods

  context 'raising errors' do

    describe 'invalid token' do
      it 'should raise an APIAccessError' do
        ACTransitRails.configure("invalidtoken")
        expect{ACTransitRails.get_all_routes}.to raise_error(ACTransitRails::APIAccessError)
      end
    end # describe invalid token

    describe 'invalid route' do
      it 'it should raise an APIAccessError' do
        ACTransitRails.configure(Secrets.ACTRANSIT_TOKEN)
        expect{ACTransitRails.get_route('invalid')}.to raise_error(ACTransitRails::APIAccessError)
      end
    end

  end # context raising errors

end # describe ActransitRails