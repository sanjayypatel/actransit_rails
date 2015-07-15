# ActransitRails

A gem for accessing the ACTransit API in Rails.  

Checkout the ACTransit [Documentation](http://api.actransit.org/transit/) for more info.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'actransit_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install actransit_rails

## Usage

1. Make sure you [register an application](http://api.actransit.org/transit/Account/Register) with ACTransit to get your access token.

2. I'd recommend using a gem like [figaro](https://github.com/laserlemon/figaro) to safely store your ACTransit access token as an environment variable.

3. In controller that will make requests to the ACTransit api, be sure to call configure with your token as an argument.

```ruby
# If you're using figaro, it would look like
ACTransitRails.configure(ENV['ACTRANSIT_TOKEN'])

# You coud also just pass it as a string, though I don't recommend that
ACTransitRails.configure("myactransittoken")
```

4. Once configured, you can use the helper methods to make requests from the api.  Responses will be formatted as either a hash or an array of hashes depending on what you request.

```ruby
# returns array of hashes
ACTransitRails.get_all_routes
# => [{"RouteId":"1","Name":"1","Description":"Bayfair Bart- Dtn. Berkeley"},...]


# returns hash
ACTransitRails.get_route('E')
# => {"RouteId":"E","Name":"E","Description":"San Francisco - Claremont -Parkwood"}

# returns array of hashes
ACTransitRails.get_trips('E')
# => [{"TripId":4119214,"RouteName":"E","ScheduleType":0,"StartTime":"2000-01-01T06:05:00","Direction":"Eastbound"},...]

# returns array of strings
ACTransitRails.get_directions('E')
# => ["Eastbound","Westbound"]

# returns array of hashes
ACTransitRails.get_stops('E')
ACTransitRails.get_stops('E', 4119214)
# => [{"StopId":58070,"Name":"Claremont Av:Hudson St","Latitude":37.8431470,"Longitude":-122.2571661,"ScheduledTime":null},...]

```


## Contributing

Make sure to setup a spec/support/secrets.rb file (see secrets_example.rb) with your token so that you can securely test.

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/actransit_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

