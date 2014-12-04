# Fagbot - the fag bot

The guy in control at #mac1 @ EFnet

    bundle install

to install shit

    rake faggot

to run shit

# Running using Vagrant

Install Vagrant and Virtualbox

    vagrant up
    vagrant ssh
    cd /vagrant
    rake faggot

to run

# How to use the fagbase for storing data

Fagbot has a built in databse. You can use it in your plugins like this:

    db = shared[:db]

    # To write data
    db.put("key", "value")

    # To fetch data
    db.get("key")

    # You can also get data from other plugins
    # Say you want the user information from the location plugin in your plugin
    db.get(m.user.nick, plugin: "location")