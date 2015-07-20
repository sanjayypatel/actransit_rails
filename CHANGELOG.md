# ActransitRails Change Log

# 07.20.15 - Version 0.2.x

## Added Error Handling based on the HTTP response codes.

* ACTransitRails will raise an APIAccessError with a `message` and `code` attributes.
* You can `rescue_from` error messages by adding a callback in your ApplicationController like this:

```ruby
rescue_from ACTransitRails::APIAccessError do |exception|
  flash[:alert] = exception.message
  redirect_to(request.referrer || root_path)
end
```