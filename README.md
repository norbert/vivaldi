# Vivaldi

Consolidated metrics for Ruby/Rack/Rails applications.

## Dependencies

* `Vivaldi::Instrument::ActiveSupportNotifications`: `activesupport`
* `Vivaldi::Instrument::ActiveRecordSQL`: `activerecord`
* `Vivaldi::Instrument::RackMiddleware`: `rack-statsd`
* `Vivaldi::Listener::Statsd`: `statsd-ruby`
* `Vivaldi::Logging`: `logging`

## Example

```ruby
Vivaldi.configure do |orchestra|
  orchestra.section :rack

  orchestra.section :rails
  orchestra.instrument :active_record_sql

  orchestra.listen Vivaldi::Listener::Statsd, 'localhost', 8125

  orchestra.logging do |logger|
    logger.level = Rails.env.development? ? :debug : :info
  end
end

Rails.application.middleware.insert_after Rack::Lock, Vivaldi::Instrument::RackMiddleware

$vivaldi = Vivaldi::Instrument
```

## References

* [Antonio Lucio Vivaldi](http://en.wikipedia.org/wiki/Antonio_Vivaldi)
* [Recomposed by Max Richter: Vivaldi, The Four Seasons](http://open.spotify.com/album/4UPS24Q2suxDzPkrxP6PAj)
