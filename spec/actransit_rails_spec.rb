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
          expect(response_hash.class).to eq(Hash)
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
        @response_without_trip = ACTransitRails.get_stops('B')
        @response_with_trip = ACTransitRails.get_stops('B', 4292041)
      end

      it 'returns an array of hashes' do
        expect(@response_without_trip.class).to eq(Array)
        expect(@response_with_trip.class).to eq(Array)
        @response_without_trip.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
        end
        @response_with_trip.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
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

    describe '.get_route_pattern' do

      before do
        @response_without_trip = ACTransitRails.get_route_pattern('B')
        @response_with_trip = ACTransitRails.get_route_pattern('B', 4292041)
      end

      it 'returns an array of hashes' do
        expect(@response_without_trip.class).to eq(Array)
        expect(@response_with_trip.class).to eq(Array)

        @response_without_trip.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
        end
        @response_with_trip.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response_without_trip.each do |response_hash|
          expect(response_hash).to have_key("TripId")
          expect(response_hash).to have_key("Sequence")
          expect(response_hash).to have_key("Latitude")
          expect(response_hash).to have_key("Longitude")
        end
        @response_with_trip.each do |response_hash|
          expect(response_hash).to have_key("TripId")
          expect(response_hash).to have_key("Sequence")
          expect(response_hash).to have_key("Latitude")
          expect(response_hash).to have_key("Longitude")
        end
      end
    end# describe .get_route_pattern

    describe '.get_all_stops' do
      before do
        @response = ACTransitRails.get_all_stops
      end

      it 'returns an array of hashes' do
        expect(@response.class).to eq(Array)
        @response.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response.each do |response_hash|
          expect(response_hash).to have_key("StopId")
          expect(response_hash).to have_key("Name")
          expect(response_hash).to have_key("Latitude")
          expect(response_hash).to have_key("Longitude")
          expect(response_hash).to have_key("ScheduledTime")
        end
      end
    end # describe .get_vehicle_predictions

    describe '.get_vehicle_predictions' do
      before do
        @response = ACTransitRails.get_vehicle_predictions(58123)
      end

      it 'returns an array of hashes' do
        expect(@response.class).to eq(Array)
        @response.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
        end
      end

      it 'should provide hashes with proper keys' do
        @response.each do |response_hash|
          expect(response_hash).to have_key("StopId")
          expect(response_hash).to have_key("TripId")
          expect(response_hash).to have_key("VehicleId")
          expect(response_hash).to have_key("RouteName")
          expect(response_hash).to have_key("PredictedDelayInSeconds")
          expect(response_hash).to have_key("PredictedDeparture")
          expect(response_hash).to have_key("PredictionDateTime")
        end
      end
    end # describe .get_vehicle_predictions

    describe '.get_vehicle' do
      before do
        @response = ACTransitRails.get_vehicle(2202)
      end

      it 'returns a hash' do
        expect(@response.class).to eq(Hash)
      end

      it 'should provide a hash with proper keys' do
        expect(@response).to have_key("VehicleId")
        expect(@response).to have_key("CurrentTripId")
        expect(@response).to have_key("Latitude")
        expect(@response).to have_key("Longitude")
        expect(@response).to have_key("Heading")
        expect(@response).to have_key("TimeLastReported")
      end
    end # describe .get_vehicle

    describe '.get_gtfs_info' do
      before do
        @response = ACTransitRails.get_gtfs_info
      end

      it 'returns a hash' do
        expect(@response.class).to eq(Hash)
      end

      it 'should provide a hash with proper keys' do
        expect(@response).to have_key("UpdatedDate")
        expect(@response).to have_key("EarliestServiceDate")
        expect(@response).to have_key("LatestServiceDate")
      end
    end # describe .get_gtfs_info

    describe '.get_service_notices' do
      before do
        @response = ACTransitRails.get_service_notices
      end

      it 'returns an array of hashes containing an array' do
        expect(@response.class).to eq(Array)
        @response.each do |response_hash|
          expect(response_hash.class).to eq(Hash)
          expect(response_hash["ImpactedRoutes"].class).to eq(Array)
        end
      end

      it 'should provide a hash with proper keys' do
        @response.each do |response_hash|
          expect(response_hash).to have_key("PostDate")
          expect(response_hash).to have_key("Title")
          expect(response_hash).to have_key("NoticeText")
          expect(response_hash).to have_key("Url")
          expect(response_hash).to have_key("ImpactedRoutes")
        end
      end

      it 'should provide an ImpactedRoutes array of strings' do
        @response.each do |response_hash|
          response_hash["ImpactedRoutes"].each do |route|
            expect(route.class).to eq(String)
          end
        end
      end
    end # describe .get_gtfs_info

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