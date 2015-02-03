# Turid, your friendly neighborhood IRC bot

This is an implementation of [Cinch](https://github.com/cinchrb/cinch), The IRC Bot Building Framework.

## Manual:

    bundle install

to install shit

    rake turid

to run shit

# Running using Vagrant

Install Vagrant and Virtualbox

    vagrant up
    vagrant ssh
    cd /vagrant
    rake turid

to run

# How to use the database for storing data

Turid has a built in databse. You can use it in your plugins like this:

    db = shared[:db]

    # To write data
    db.put("key", "value")

    # To fetch data
    db.get("key")

    # You can also get data from other plugins
    # Say you want the user information from the location plugin in your plugin
    db.get(m.user.nick, plugin: "location")
