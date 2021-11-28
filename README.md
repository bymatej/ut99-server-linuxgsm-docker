# ut99-server-linuxgsm-docker
Unreal Tournament 2000 Server in Docker container installed with LinuxGSM

# Intro
After fiddling around with my past projects, I wanted to start from scratch and create a new UT2000 server to my likings.

Things I wanted: 
- Containerized server (docker)
- With nice admin GUI (old UT server admin)
- With a File browser (filebrowser app - web gui for file browsing)
- Some level of customization on server creation

## Sources I used to make the server (including my past projects)
- https://github.com/bymatej/ut99-server
- https://github.com/bymatej/ut99-patching-guide
- https://linuxgsm.com/servers/ut99server/
- https://docs.linuxgsm.com/game-servers/unreal-tournament-99
- https://filebrowser.org/installation
- https://tonyteaches.tech/filebrowser-tutorial/
- https://github.com/hurlenko/filebrowser-docker/

# Overview

## This Docker image consists of the following:
### Filebrowser
A web based file browser that enables the file management of the files inside the container. 

No volumes are used. This server was never intended to be used like a "real" server 
(the one that you'd maintain and care about), but rather as a quick spin-up server.

So, the need for a tool like filebrowser was to be able to quickly update the server details (name, number of players, etc.).

I will add volumes in the future if I need them personally.

- Filebrowser: https://filebrowser.org/

### LinuxGSM
This is a Game Server Management tool for linux. It is great, since it takes the hassle of dependencies installation 
away from you. And also, Unreal Tournament 2000 was supported and updated to the latest version.

- Linux GSM: https://linuxgsm.com/

### Unreal Tournament 2000 server
The UT99 game server updated to the lates patch 469 (by LinuxGSM) with its admin console.

- Unreal Tournament 2000: https://unreal.fandom.com/wiki/Unreal_Tournament 
- Patch v469: https://github.com/OldUnreal/UnrealTournamentPatches/releases/tag/v469b 
- Community: https://ut99.org/

# Installation

## Building the image
Run this command
```
docker build -t bymatej/ut99-linuxgsm \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  .
```

## Running the container

Run this command
```
docker run -d \
  -p 7777-7779:7777-7779/tcp \
  -p 7777-7779:7777-7779/udp \
  -p 8075-8077:8075-8077/tcp \
  -p 8075-8077:8075-8077/udp \
  -p 28900-28902:28900-28902/tcp \
  -p 28900-28902:28900-28902/udp \
  -p 8080:8080 \
  --name ut99-linuxgsm \
  bymatej/ut99-linuxgsm:latest
```

# Sources for maps, mods, game types and mutators
- http://www.ut-files.com/
- https://unrealarchive.org/
- https://www.mapraider.com/maps/unreal-tournament
- https://www.moddb.com/games/unreal-tournament
- http://medor.no-ip.org/

Filebrowser may come in handy when putting new maps/mods on the server. 

# ToDo
## Introduce customization on docker run
- Mods, maps, server name, etc.
- kind of like on: https://github.com/bymatej/ut99-server but simpler

## Introduce volumes
- This way this server cannot be migrated and the content inside the container is dependant on that container
- This is not how Docker should be used, but I just wanted it this way for now

## Add more maps/mods by default
- Monsterhunt, zeroping, mapvotela, etc.

## Remove unnecesarry ports (`EXPOSE` and `-p`)
