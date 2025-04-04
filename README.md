Introduction
============
This application connects to the Microsoft SQL back-end of a [Trapeze EAM][1]
installation and provides API endpoints (in JSON format) for fueling
information.

It's unlikely that this project fulfills a need for anyone other than us, but
you never know...

API
===
Every JSON response has the following format:

```json
{ "connection_valid": true,
  "error":            "If connection_valid is false, why?",
  "fueling":          [
                        {
                        "EQ_equip_no":       "vehicle_name",
                        "amount":            10.0,
                        "fuel_focus_row_id": 12345,
                        "mileage":           100234,
                        "time_at":           "2000-01-01T00:00:30.000Z",
                        "time_at_insertion": "2000-01-01T00:00:40.000Z"
                        }, "etc"
                      ]
}
```

`time_at` is the date and time of the actual fueling (from the pump), while
`time_at_insertion` is the time that it made it into the database.

API URLs
--------
`GET /vehicle/<vehicle name>`
> returns all fuelings for the specified vehicle

`GET /vehicle/<vehicle name>/<timestamp>`
> returns all fuelings for the specified vehicle since the given Unix
> timestamp

`GET /vehicle/<vehicle name>/<start>/<end>`
> returns all fuelings for the specified vehicle between the two Unix
> timestamps, "start" and "end"

`GET /all/<timestamp>`
> returns all fuelings since the given Unix timestamp

`GET /all/<start>/<end>`
> returns all fuelings that happened between the two Unix timestamps, "start"
> and "end"

Development
===========
The application was built on the Sinatra framework with ActiveRecord as an ORM. It is reccommended you use rbenv to
install/manage ruby.

When running the development server, it is recommended you open a tunnel to the production database using the provided
script.

Setup
-----
1) Install ruby. (`rbenv install`)
2) Run the setup script. (`bin/setup`)
3) Place the credentials key file in `config/fleetfocus-api.key`. (Get from KeePass or another developer)

Scripts
-------
```bash
bin/bundle     # install dependencies
bin/rake       # run tasks
bin/rspec      # run specs
bin/rubocop    # run linter
script/console # run irb
script/server  # run server - requires database tunnel
script/setup   # set up development environment
script/tunnel  # open a database tunnel to the production server - requires ssh access, vpn connection, credentials key
```

License
=======
This code is released under the MIT license.  See the file `LICENSE` for more info.

[1]: http://www.trapezegroup.com/enterprise-asset-management
[2]: http://bundler.io/
[3]: http://www.sinatrarb.com/
[4]: http://rack.github.io/
