#!/usr/bin/env python3
import sys
import dbus
import json
import argparse
from pathlib import Path
from gi.repository import GLib
from dbus.mainloop.glib import DBusGMainLoop

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('--player', type=str, help='Player to control (default: any)')
    return parser.parse_args()

def format_output(player, metadata, player_status):
    if player.startswith('org.mpris.MediaPlayer2.spotify'):
        icon = ""
    else:
        icon = "🎜"
        
    if player_status == 'Playing':
        track = metadata.get('xesam:title', 'Unknown Track')
        artist = metadata.get('xesam:artist', ['Unknown Artist'])[0]
        output = f"{artist} - {track}"
        return json.dumps({"text": output, "class": player_status.lower(), "alt": output, "icon": icon})
    else:
        return json.dumps({"text": "", "class": "stopped", "alt": "Stopped", "icon": icon})

def get_players():
    bus = dbus.SessionBus()
    players = [
        service for service in bus.list_names() 
        if service.startswith('org.mpris.MediaPlayer2.')
    ]
    return players

def get_player_status(player):
    bus = dbus.SessionBus()
    try:
        proxy = bus.get_object(player, '/org/mpris/MediaPlayer2')
        properties = dbus.Interface(proxy, 'org.freedesktop.DBus.Properties')
        metadata = properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
        status = properties.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')
        return metadata, status
    except dbus.exceptions.DBusException:
        return {}, 'Stopped'

def main():
    args = parse_arguments()
    players = get_players()
    
    if not players:
        print(json.dumps({"text": "", "class": "stopped", "alt": "No players found"}))
        return
    
    if args.player:
        player_name = f"org.mpris.MediaPlayer2.{args.player}"
        if player_name in players:
            players = [player_name]
        else:
            print(json.dumps({"text": "", "class": "stopped", "alt": f"Player {args.player} not found"}))
            return
    
    # Get first active player
    for player in players:
        metadata, status = get_player_status(player)
        if status == 'Playing':
            print(format_output(player, metadata, status))
            return
    
    # If no active player, show first available player
    metadata, status = get_player_status(players[0])
    print(format_output(players[0], metadata, status))

if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        print(json.dumps({"text": "Error", "class": "error", "alt": str(e)}))
