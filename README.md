# ClicksignRb

Interface to the ClickSign REST api.


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`.


## Build
```ruby
bundle exec rake build
```

## Instalation
```ruby
bundle exec rake install
```


## Usage

### Library
```ruby
require 'clicksign_rb'


ClicksignRB.configure do |config|
  # Required
  #
  config.host  = 'https://sandbox.clicksign.com/api'
  config.token = 'ACCESS_TOKEN'

  # Optional
  #
  # config.api_version
  # config.logger.out
  # config.logger.level
  # config.logger.progname
  # config.logger.formatter
  # config.logger.http_debug
end


ClicksignRB::Document.create_through_file_upload(
    file: '/path/to/original/document/file.pdf',
    path: '/paht/to/clicksign/destination/file.pdf',

    deadline_at: '2019-11-28T14:30:59-03:00', # optional
    auto_close: false,                        # optional
    locale: 'en-US',                          # optional
    sequence_enabled: true,                   # optional
    remind_interval: 1                        # optional
)
```

### CLI
The executable `./exe/clicksign_rb` should be available systemwide after gem instalation.

The cli is fully documented, argument list for the document creation are available.

```bash
$ clicksign_rb document create_through_upload --help
Usage:
  clicksign_rb document create_through_upload

Options:
  --path=PATH
  --file=FILE
  --token=TOKEN
  [--test], [--no-test]
  [--deadline-at=DEADLINE_AT]
  [--auto-close], [--no-auto-close]
  [--locale=LOCALE]
  [--sequence-enabled], [--no-sequence-enabled]
  [--remind-interval=REMIND_INTERVAL]

creates a document through file upload
```

- Note that the `--test` option uses the **sandbox** clicksign api.


#### Example
```bash
$ clicksign_rb document create_through_upload \\
    --file /path/to/original/document/file.pdf \\
    --path paht/to/clicksign/destination/file.pdf \\
    --token ACCESS_TOKEN \\
    --auto-close \\
    --test
```
