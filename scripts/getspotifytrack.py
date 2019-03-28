#!/usr/bin/env python3
import dbus
session_bus = dbus.SessionBus()
try:
    spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")
    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
except:
	print("")
	exit(0)

# Print Artist + Title
for artist in metadata['xesam:artist']:
    print(" " + str(artist) + " - " + str(metadata['xesam:title']))
exit(0)