# CampfireRepl

Simple REPL to interact with 37Signals Campfire application.

## Installation

    $ gem install campfire_repl

## Usage

Fire up the REPL using the campfire_repl executable

    campfire_repl

Instructions consist of the command to run first, followed by any parameters.  If one ofthe parameters has a space or non alphanumeric characters, enclose it in double quotes.

    >> command arg1 "first_name.last_name" "my room"

Login to your Campfire account

    >> login mysubdomain "alexander.graham.bell" "teleph0n3"

    >> login mysubdomain your_api_auth_token

You can also create a json file that contains your login info and pass that as a parameter to the campfire_repl executable.

    campfire_repl config.json

The contents of config.json should look like

    {
      "account": "mysubdomain",
      "token": "1234567890"
    }

or

    {
      "account": "mysubdomain",
      "username": "alexander.graham.bell",
      "password": "teleph0n3"
    }

See what rooms are available

    >> show_rooms

Join a room either by the room id or room name

    >> join_room 1234

    >> join_room "My Room"

Show users in the current room

    >> show_users

Get recent messages posted to the room (10 is default)

    >> show_recent_messages 30

Leave the room

    >> leave_room

Listen to messages

    >> listen

Say something in the room

    >> speak "Mr. Watson, come here, I want to see you"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
