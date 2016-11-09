Introduction
============
This application connects to the Microsoft SQL back-end of a [Trapeze EAM][1]
installation and provides API endpints (in JSON format) for fueling
information.

It's unlikely that this project fulfills a need for anyone other than us, but
you never know...

Configuration
=============
This application only knows how to communicate with the MS-SQL-backed Fleet
Focus.  If you have an Oracle-backed installation, we can't help you.

Create a `database.yml` file in the `config` directory and fill in your
database information.  The MS-SQL username specified here **only** needs
read-only access to the `FTK_MAIN` table.

```yaml
development:
  adapter:  sqlserver
  host:     dev.example.com
  database: dbname
  username: username
  password: password
  
production:
  adapter:  sqlserver
  host:     prod.example.com
  database: dbname
  username: username
  password: password
```

Install the gem requirements with [Bundler][2].

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
                        "time_at":           "2000/01/01 00:00:00 -0400",
                        "time_at_insertion": "2000/01/01 00:00:40 -0400"
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
> returns all fuelings for the specified vehicle since the given unix
> timestamp

`GET /vehicle/<vehicle name>/<start>/<end>`
> returns all fuelings for the specified vehicle between the two unix
> timestamps, "start" and "end"

`GET /all/<timestamp>`
> returns all fuelings since the given unix timestmp

`GET /all/<start>/<end>`
> returns all fuelings that happened between the two unix timestamps, "start"
> and "end"

Running the app
===============
It's a [sinatra][3] application, so it can run under [Rack][4]

```bash
$ rackup
[2012-05-07 18:56:14] INFO  WEBrick 1.3.1
[2012-05-07 18:56:14] INFO  ruby 1.9.3 (2011-07-31) [x86_64-darwin11.2.0]
[2012-05-07 18:56:14] INFO  WEBrick::HTTPServer#start: pid=74781 port=9292
```

License
=======
This code is released under the MIT license.  See the file `LICENSE` for more
info.

[1]: http://www.trapezegroup.com/enterprise-asset-management
[2]: http://bundler.io/
[3]: http://www.sinatrarb.com/
[4]: http://rack.github.io/
