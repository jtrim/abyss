# Abyss

Ruby DSL for defining arbitrarily-deep configuration.

## Installation

Add this line to your application's Gemfile:

    gem 'abyss'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install abyss

## Usage

    Abyss.configure do

      # An arbitrarily-named configuration group
      #
      rush do

        # Define arbitrary properties
        #
        year_founded '1968'
        members ["Geddy", "Alex", "Neil"]

      end

    end

    # Accessing...
    Abyss.configuration.rush.year_founded #=> "1968"
    Abyss.configuration.rush.members #=> ["Geddy", "Alex", "Neil"]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
